module Concerns
  module Eventable
    extend ActiveSupport::Concern

    included do
      has_many :events, as: :target

      after_create :trigger_created_event
      after_destroy :trigger_deleted_event
    end

    def trigger_event(action, initiator_id,)
      Event.new(
          action: action,
          initiator_id: initiator_id,
          target_id: self.id,
          target_type: self.class.to_s,
          projectable_id: fetch_projectable_id,
          projectable_type: project.class.to_s
      )
    end

    def fetch_projectable_id
      case self
        when Project
          self.id
        when Todo
          self.project.id
        when CalendarEvent
          self.caleventable.id
        else
          raise '不支持的类型!'
      end
    end
  end
end
