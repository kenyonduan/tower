# == Schema Information
#
# Table name: todos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  deadline    :date
#  status      :integer          default(0)
#  project_id  :integer
#  creator_id  :integer
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Todo, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
