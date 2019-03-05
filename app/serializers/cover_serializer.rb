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
#  role           :integer          default("photo")
#

class CoverSerializer < ActiveModel::Serializer
  require 'uri'
  
  attributes :id, :url
  has_many :comments, serializer: CommentSerializer

  def url
    if object.photo_message.present?
      object.photo_message.url
    elsif object.coverable.text_message.present?
      "https://res.cloudinary.com/hajcm9hwg/image/upload/e_brightness:30,o_80/w_430,c_fit,l_text:Sawarabi%20Gothic_35:#{URI.escape(object.coverable.text_message)}/dphwltrgho6nk3ys2nun.png"
    else
      "https://res.cloudinary.com/hajcm9hwg/image/upload/e_brightness:30,o_80/w_430,c_fit,l_text:Sawarabi%20Gothic_35:#{URI.escape(object.coverable.title)}/dphwltrgho6nk3ys2nun.png"
    end
  end
end
