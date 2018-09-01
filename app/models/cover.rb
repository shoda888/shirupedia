class Cover < ApplicationRecord
  mount_uploader :photo_message, FileUploader
  belongs_to :coverable, polymorphic: true
end
