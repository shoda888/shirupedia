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
#

class Cover < ApplicationRecord
  mount_uploader :photo_message, PhotoMessageUploader
  belongs_to :coverable, polymorphic: true
end
