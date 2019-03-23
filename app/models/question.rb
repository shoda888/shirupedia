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

  def share_url
    Rails.application.routes.url_helpers.question_url(self)
  end
end
