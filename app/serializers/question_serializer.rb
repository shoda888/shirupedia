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
