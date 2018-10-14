# == Schema Information
#
# Table name: nices
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  cover_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Nice < ApplicationRecord
  belongs_to :user
  belongs_to :cover
  validates :user_id, presence: true
  validates :cover_id, presence: true
end
