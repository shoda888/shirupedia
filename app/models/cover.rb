class Cover < ApplicationRecord
  mount_uploader :photo_message, PhotoMessageUploader
  belongs_to :coverable, polymorphic: true
end
