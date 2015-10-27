class Event < ActiveRecord::Base
  belongs_to :initiator, class_name: 'User'
  belongs_to :resource, polymorphic: true
end
