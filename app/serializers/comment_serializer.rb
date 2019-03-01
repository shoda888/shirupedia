class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user_id
  attribute :avatar

  def avatar
    object.user.profile.avatar.url
  end

end
