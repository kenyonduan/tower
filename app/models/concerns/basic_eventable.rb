module Concerns
  module BasicEventable
    extend ActiveSupport::Concern

    included do
      has_many :events, as: :target

      after_create :trigger_created_event
    end

    def action_2_json(action, action_params)
      {
          action: action,
          params: action_params
      }.to_json
    end
  end
end
