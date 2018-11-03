class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :grade, :school, :department, :lesson
  
end
