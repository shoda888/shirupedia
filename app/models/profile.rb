class Profile < ApplicationRecord
  belongs_to :user
  validates :grade, presence: true
  validates :department, presence: true

end
