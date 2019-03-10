# == Schema Information
#
# Table name: questions
#
#  id           :bigint(8)        not null, primary key
#  title        :string
#  aasm_state   :string
#  user_id      :integer
#  text_message :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Question < ApplicationRecord
  acts_as_taggable_on :fields
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :covers, as: :coverable, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :iine_users, through: :likes, source: :user

  # scope :searched_by_same_school_person, -> (school) { joins(:user).merge(User.searched_by_same_school(school)) } # 同じ学院の人の質問を抽出
  # scope :searched_by_same_department_person, -> (department) { joins(:user).merge(User.searched_by_same_department(department)) } # 同じ系の人の質問を抽出
  # scope :exclude_my_questions, -> (user_id) { where.not(user_id: user_id) } # 自分の質問を除く
  scope :search, -> (word) { where(['title LIKE ? OR text_message LIKE ?', "%#{word}%", "%#{word}%"]) }

  validates :title, presence: true

  include AASM

  aasm do
    state :wanted, initial: true
    state :closed

    event :close do
      transitions from: :wanted, to: :closed
    end
    event :public do
      transitions from: :closed, to: :wanted
    end
  end

  def iine?(user)
    iine_users.include?(user)
  end

  def good(user)
    likes.create(user_id: user.id)
  end

  def good_cancel(user)
    likes.find_by(user_id: user.id).destroy
  end

  # def self.find_same_school_questions_exclude_mine(school, user_id)
  #   searched_by_same_school_person(school).exclude_my_questions(user_id)
  # end

  # def self.find_same_department_questions_exclude_mine(school, user_id)
  #   searched_by_same_department_person(school).exclude_my_questions(user_id)
  # end
end
