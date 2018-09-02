class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :covers, as: :coverable, dependent: :destroy
end
