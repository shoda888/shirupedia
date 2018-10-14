# == Schema Information
#
# Table name: likes
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :question
  validates :user_id, presence: true
  validates :question_id, presence: true
end
