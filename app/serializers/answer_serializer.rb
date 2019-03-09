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
  attributes :id, :good_answer, :nice_shot
  belongs_to :user, serializer: UserSerializer
  has_many :covers, serializer: CoverSerializer

  def good_answer
    object.best?
  end

  def nice_shot
    shot = []
    object.covers.each do |cover|
      shot << cover.id if cover.nices.present?
    end
    shot
  end
end
