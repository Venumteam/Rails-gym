class PostSerializer < ActiveModel::Serializer
  attributes :id, :subtitle, :created_at, :description, :title,
             :likes_count, :comments_count, :type

  has_many :comments, :polymorphic => true, serializer: CommentSerializer
  has_many :likes, :polymorphic => true, serializer: LikeSerializer
  has_many :categories, serializer: CategorySerializer
end
