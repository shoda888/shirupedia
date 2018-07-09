class Question < ApplicationRecord
  # carrierwaveとモデルの関連付け
  mount_uploader :file, FileUploader

  acts_as_taggable_on :fields
  belongs_to :user
  has_many :answers
  include AASM

  aasm do
    state :wanted, :initial => true
    state :completed

    event :finish do
      transitions :from => :wanted, :to => :completed
    end
  end

  def self.search(search) #self.でクラスメソッドとしている
    if search # Controllerから渡されたパラメータが!= nilの場合は、titleカラムを部分一致検索
      Question.where(['title LIKE ?', "%#{search}%"])
    else
      Question.all #全て表示。
    end
  end
end
