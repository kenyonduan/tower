# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  name       :string
#  project_id :integer
#  creator_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  list_type  :integer
#

require 'rails_helper'

RSpec.describe TodoList, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
