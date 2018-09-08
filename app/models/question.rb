# == Schema Information
#
# Table name: questions
#
#  id         :bigint(8)        not null, primary key
#  title      :string
#  aasm_state :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ApplicationRecord
  acts_as_taggable_on :fields
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :covers, as: :coverable, dependent: :destroy
  include AASM

  aasm do
    state :wanted, initial: true
    state :completed

    event :finish do
      transitions from: :wanted, to: :completed
    end
  end

  def self.search(search) # self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Question.where(['title LIKE ?', "%#{search}%"])
    else
      Question.all # 全て表示。
    end
  end
end
