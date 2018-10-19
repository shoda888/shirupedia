# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_one :profile
  has_many :questions
  has_many :answers
  has_many :likes, dependent: :destroy
  has_many :nices, dependent: :destroy
  has_many :comments, dependent: :destroy


  # validates :email, format: { with: /.+@m.titech.ac.jp/ }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, presence: true, length: { in: 1..30 }, on: :update
end
