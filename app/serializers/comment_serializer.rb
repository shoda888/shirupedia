# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  user_id    :integer
#  cover_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at
  attribute :avatar
  belongs_to :user, serializer: UserSerializer

  def avatar
    object.user.profile.avatar.url
  end
end
