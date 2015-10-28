class Event < ActiveRecord::Base
  belongs_to :initiator, class_name: 'User'
  # 关系链中最高级别的父对象(Project、Calendar)
  belongs_to :projectable, polymorphic: true
  # 作用与哪个目标对象(Todo)
  belongs_to :target, polymorphic: true

  # Event 负责处理通用的 Action event
end
