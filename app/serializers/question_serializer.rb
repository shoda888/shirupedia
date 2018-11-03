class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title, :fields
  has_many :answers, serializer: AnswerSerializer
  has_many :covers, serializer: CoverSerializer
  has_many :likes, serializer: LikeSerializer
  belongs_to :user, serializer: UserSerializer
end
