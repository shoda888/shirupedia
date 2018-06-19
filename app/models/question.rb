class Question < ApplicationRecord
  acts_as_taggable_on :fields
  belongs_to :user
  include AASM

  aasm do
    state :wanted, :initial => true
    state :completed

    event :finish do
      transitions :from => :wanted, :to => :completed
    end
  end
end
