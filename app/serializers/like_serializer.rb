# == Schema Information
#
# Table name: likes
#
#  id          :bigint(8)        not null, primary key
#  user_id     :integer          not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class LikeSerializer < ActiveModel::Serializer
  attributes :id
end
