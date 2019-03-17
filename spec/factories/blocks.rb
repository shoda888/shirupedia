# == Schema Information
#
# Table name: blocks
#
#  id             :bigint(8)        not null, primary key
#  user_id        :integer          not null
#  target_user_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :block do
    user { nil }
  end
end
