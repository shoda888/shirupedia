# == Schema Information
#
# Table name: comments
#
#  id         :bigint(8)        not null, primary key
#  content    :string
#  user_id    :integer
#  cover_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :comment do
    content { 'MyString' }
  end
end
