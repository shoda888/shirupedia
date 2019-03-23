# == Schema Information
#
# Table name: answers
#
#  id           :bigint(8)        not null, primary key
#  text_message :string
#  user_id      :integer
#  question_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Answer < ApplicationRecord
  after_create :notice_answer_came
  belongs_to :user
  belongs_to :question
  has_many :covers, as: :coverable, dependent: :destroy

  def best?
    covers.each do |cover|
      return true if cover.nices.present?
    end
    false
  end

  def notice_answer_came
    UserMailer.notification_answer(question.share_url, user.name, question.user.email).deliver_now
  end
end
