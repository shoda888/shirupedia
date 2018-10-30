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

FactoryBot.define do
  factory :like do
    user_id { 1 }
    question_id { 1 }
  end
end
