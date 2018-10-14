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

require 'rails_helper'

RSpec.describe Nice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
