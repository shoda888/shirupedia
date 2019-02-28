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

class AnswerSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :user, serializer: UserSerializer
  has_many :covers, serializer: CoverSerializer
end
