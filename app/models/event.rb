class Event < ActiveRecord::Base
  # 多种类型的资源都有 Event
  belongs_to :eventable, polymorphic: true
end
