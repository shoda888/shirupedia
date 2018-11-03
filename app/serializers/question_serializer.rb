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

class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :fields, :aasm_state
  has_many :answers, serializer: AnswerSerializer
  has_many :covers, serializer: CoverSerializer
  has_many :likes, serializer: LikeSerializer
  belongs_to :user, serializer: UserSerializer

  attribute :count_answers

  def count_answers
    object.answers.length
  end
end
