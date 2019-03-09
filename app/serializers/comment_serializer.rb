class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  attribute :avatar
  belongs_to :user, serializer: UserSerializer

  def avatar
    object.user.profile.avatar.url
  end
end
