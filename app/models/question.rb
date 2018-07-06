class Question < ApplicationRecord
  # carrierwaveとモデルの関連付け
  mount_uploader :file, FileUploader

  acts_as_taggable_on :fields
  belongs_to :user
  has_many :answers
  include AASM

  aasm do
    state :wanted, :initial => true
    state :completed

    event :finish do
      transitions :from => :wanted, :to => :completed
    end
  end
end
