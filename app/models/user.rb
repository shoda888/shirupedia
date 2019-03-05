# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string
#

class User < ApplicationRecord
  has_secure_password validations: false
  has_secure_token
  has_one :profile
  has_many :questions
  has_many :answers
  has_many :answeredquestions, through: :answers, source: :question
  has_many :likes, dependent: :destroy
  has_many :nices, dependent: :destroy
  has_many :comments, dependent: :destroy

  scope :searched_by_same_school, -> (school) { joins(:profile).merge(Profile.searched_by_school(school)) }
  scope :searched_by_same_department, -> (department) { joins(:profile).merge(Profile.searched_by_department(department)) }

  validates :email, format: { with: /+.titech.ac.jp/ }
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  # validates :password, presence: true, length: { in: 1..30 }, on: :update
  validate(on: :update) do |record|
    record.errors.add(:password, :blank) unless record.password_digest.present?
  end

  validates :password, length: { maximum: ActiveModel::SecurePassword::MAX_PASSWORD_LENGTH_ALLOWED }, on: :update
  validates :password, confirmation: true, allow_blank: true, on: :update
end
