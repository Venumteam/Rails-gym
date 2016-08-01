class TrainingDiariesController < ApiController
  load_resource
  before_action :set_period_boundaries, only: :diary_stats

  def index
    render_resources @training_diaries.includes(:training_diary_exercises)
  end

  def create
    @training_diary.list_of_exercise_id = params[:list_of_exercise_id]
    @training_diary.save
    render_resource_or_errors(@training_diary)
  end

  def update
    @training_diary.update_attributes(training_diary_params)
    render_resource_or_errors(@training_diary)
  end

  def destroy
    @training_diary.destroy
    render nothing: true
  end

  def diary_stats
    training_exercises = @training_diaries.ransack(list_of_exercise_id_eq: params[:exercise]).result
    training_exercises = training_exercises.stats_by_period(@start_period, @end_period).order(:date)
    filtered_weights = filter_weights(training_exercises.includes(:training_diary_exercises))
    filtered_dates = training_exercises.pluck(:date).map { |date| Date.parse(date.to_s).to_formatted_s(:iso8601) }

    stats = {
        dates: filtered_dates.empty? ? last_week_dates : filtered_dates,
        weights: Array.new(1, filtered_weights.empty? ? Array.new(last_week_dates.length, 0) : filtered_weights),
        max_weight: filtered_weights.max,
        exercises_categories: exercises_names(@training_diaries),
        exercises_count: exercises_count(@training_diaries)
    }
    render json: stats
  end

  def training_diary_params
    params.require(:resource).permit(:exercise, :sets, :date, training_diary_exercises_attributes: [:repetition, :weight])
  end

  private

  def last_week_dates
    (@start_period.to_datetime..@end_period.to_datetime).map{ |date| Date.parse(date.to_s).to_formatted_s(:iso8601) }
  end

  def filter_weights(diaries)
    diaries.map do |diary|
      diary.training_diary_exercises.map(&:weight).max
    end
  end

  def exercises_names(exercises_items)
    @exercises = []
    exercises_items.each { |exercise| @exercises << exercise.list_of_exercise.title }
    @exercises.uniq
  end

  def exercises_count(exercises_items)
    exercises_counts = []
    items = exercises_items.to_a
    @exercises.map { |exercise| exercises_counts << items.select { |i| i.list_of_exercise.title == exercise}.length }
    exercises_counts
  end

  def set_period_boundaries
    @start_period = (params[:start_period].present? ? Time.zone.parse(params[:start_period]) : Time.current).beginning_of_day
    @end_period = (params[:end_period].present? ? Time.zone.parse(params[:end_period]) : Time.current).end_of_day
  end
end
