# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
  has_one :profile
  has_many :questions
  has_many :answers

  validates :email, format: { with: /.+@m.titech.ac.jp/ }
  validates :name, presence: true
  # validates :password, presence: true, uniqueness: true, length: { in: 1..10 }
end
