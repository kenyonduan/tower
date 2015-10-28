class EventsController < ApplicationController
  def index
    @project_ids = current_user.projects.pluck(:id)
    @calendar_ids = current_user.calendars.pluck(:id)
    @events = EventForm.new(p_ids: @project_ids, c_ids: @calendar_ids, page: params[:page]).query
  end
end
