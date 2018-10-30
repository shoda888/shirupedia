class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :cover
  validates :user_id, presence: true
  validates :cover_id, presence: true
end
