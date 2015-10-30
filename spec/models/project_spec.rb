# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  name           :string
#  team_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  description    :text
#  guest_lockable :boolean          default(FALSE)
#  project_type   :integer
#  creator_id     :integer
#

require 'rails_helper'

RSpec.describe Project, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
