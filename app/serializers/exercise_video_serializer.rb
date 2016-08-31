class ExerciseVideoSerializer < ExerciseSerializer
  attributes :link, :video_id, :service, :image

  def image
    (object.image? ? object.image.serializable_hash : {}).tap do |hash|
      hash[:auto_generated] = object.preview_image.url if object.preview_image?
    end
  end
end