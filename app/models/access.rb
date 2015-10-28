class Access < ActiveRecord::Base
  belongs_to :user
  # 访问权限可以属于多种类型的资源(Project、Calendar)
  belongs_to :resource, polymorphic: true
end
