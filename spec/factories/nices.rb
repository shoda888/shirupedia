# == Schema Information
#
# Table name: nices
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  cover_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :nice do
    user_id { 1 }
    cover_id { 1 }
  end
end
