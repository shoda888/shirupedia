# == Schema Information
#
# Table name: covers
#
#  id             :bigint(8)        not null, primary key
#  coverable_type :string
#  coverable_id   :bigint(8)
#  photo_message  :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class CoverSerializer < ActiveModel::Serializer
  attributes :id
end