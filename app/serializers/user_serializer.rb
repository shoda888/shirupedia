# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string
#

class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :is_blocked
  has_one :profile, serializer: ProfileSerializer

  def is_blocked
    Block.where(target_user_id: object.id).pluck(:user_id).include?(scope[:current_user_id])
  end
end
