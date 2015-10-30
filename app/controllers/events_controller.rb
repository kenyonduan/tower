class EventsController < ApplicationController
  before_action :find_team, only: :index

  def index
    project_ids, calendar_ids = current_user.accessible_projects_id(@team), current_user.accessible_calendars_id(@team)
    @events = EventForm.new(p_ids: project_ids, c_ids: calendar_ids, page: params[:page]).query
  end

  private
  def find_team
    @team = Team.find(params[:team_id])
  end
end
