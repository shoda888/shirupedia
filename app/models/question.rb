class Question < ApplicationRecord
  acts_as_taggable_on :fields
  belongs_to :user
end
