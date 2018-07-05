class User < ApplicationRecord
  has_one :profile
  has_many :questions
  has_many :answers

  validates :email, format: { with: /.+@m.titech.ac.jp/ }
  validates :name, presence: true
  # validates :password, presence: true, uniqueness: true, length: { in: 1..10 }
end
