class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :initiator, class_name: 'User'
  # 多种类型的资源都有 Event
  belongs_to :eventable, polymorphic: true
end
