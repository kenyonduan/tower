module Concerns
  module BasicEventable
    extend ActiveSupport::Concern

    included do
      has_many :events, as: :target

      after_create :trigger_created_event
      after_destroy :trigger_deleted_event
    end

    def trigger_event(initiator_id, action, action_params=[])
      basic_params = {
          action: action_2_json(action, action_params),
          type: 'Event',
          initiator_id: initiator_id,
          target_id: self.id,
          target_type: self.class.to_s
      }
      Event.create(basic_params.merge!(projectable_params))
    end

    def action_2_json(action, action_params)
      {
          action: action,
          params: action_params
      }.to_json
    end

    def projectable_params
      case self
        when Project
          {projectable_id: self.id, projectable_type: 'Project'}
        when Todo
          {projectable_id: self.project.id, projectable_type: 'Project'}
        when CalendarEvent
          {projectable_id: self.caleventable.id, projectable_type: 'Calendar'}
        else
          {}
      end
    end
  end
end
