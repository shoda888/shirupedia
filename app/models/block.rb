# == Schema Information
#
# Table name: blocks
#
#  id             :bigint(8)        not null, primary key
#  user_id        :integer          not null
#  target_user_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Block < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, dependent: :destroy, class_name: 'User', foreign_key: 'target_user_id'
end
