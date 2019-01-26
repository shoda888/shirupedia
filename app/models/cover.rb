# == Schema Information
#
# Table name: covers
#
#  id             :bigint(8)        not null, primary key
#  coverable_type :string
#  coverable_id   :bigint(8)
#  photo_message  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  role           :integer          default("photo")
#

class Cover < ApplicationRecord
  mount_uploader :photo_message, PhotoMessageUploader
  belongs_to :coverable, polymorphic: true
  has_many :nices, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :nice_users, through: :nices, source: :user

  enum role: { photo: 1, text: 2}
  # photo: フォトカバー
  # text: テキストカバー

  def nice?(user)
    nice_users.include?(user)
  end

  def nice(user)
    nices.create(user_id: user.id)
  end

  def nice_cancel(user)
    nices.find_by(user_id: user.id).destroy
  end
end
