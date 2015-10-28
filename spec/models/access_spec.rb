# == Schema Information
#
# Table name: accesses
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  resource_id   :integer
#  resource_type :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe Access, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
