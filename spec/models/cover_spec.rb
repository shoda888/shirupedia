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

require 'rails_helper'

RSpec.describe Cover, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
