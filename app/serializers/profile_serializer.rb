# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  avatar     :string
#  grade      :string
#  school     :string
#  department :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  token      :string
#

class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :grade, :school, :department, :lesson_list, :interest_list, :token
end
