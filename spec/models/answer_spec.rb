# == Schema Information
#
# Table name: answers
#
#  id           :bigint(8)        not null, primary key
#  text_message :string
#  user_id      :integer
#  question_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
