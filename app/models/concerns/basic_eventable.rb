module Concerns
  module BasicEventable
    extend ActiveSupport::Concern

    included do
      has_many :events, as: :target

      after_create :trigger_created_event
      before_destroy :trigger_deleted_event
    end
  end
end
