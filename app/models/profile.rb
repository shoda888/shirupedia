# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  avatar     :string
#  grade      :string
#  school     :string
#  department :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string
#

class Profile < ApplicationRecord
  acts_as_taggable_on :interests, :lessons
  # carrierwaveとモデルの関連付け
  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  # validates :grade, presence: true
  # validates :department, presence: true
end
