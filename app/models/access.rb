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

class Access < ActiveRecord::Base
  belongs_to :user
  # 访问权限可以属于多种类型的资源(Project、Calendar)
  belongs_to :resource, polymorphic: true
end
