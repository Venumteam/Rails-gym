class CommentsController < ApiController
  load_and_authorize_resource

  def index
    comments = Comment.where(post_id: params[:post_id]).includes(:user)
    render_resources(comments)
  end

  def show
    comment = Comment.find_by(id: params[:id])
    render_resource_data(comment)
  end

  def create
    @comment.save
    render_resource_or_errors(@comment)
  end

  def update
    @comments.update(comment_params)
    render_resource_or_errors(@comments)
  end

  def destroy
    @comments.destroy
    render nothing: true
  end

  private

  def comment_params
    params.allow_empty_require(:resource).permit(:message, :comment_date, :user_id, :post_id, :name, :email)
  end
end
