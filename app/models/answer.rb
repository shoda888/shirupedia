class Answer < ApplicationRecord
  # carrierwaveとモデルの関連付け
  mount_uploader :file, FileUploader

  belongs_to :user
  belongs_to :question
end
