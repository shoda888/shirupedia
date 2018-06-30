class Profile < ApplicationRecord
  # carrierwaveとモデルの関連付け
  mount_uploader :avatar, AvatarUploader

  belongs_to :user
  validates :grade, presence: true
  validates :department, presence: true

end
