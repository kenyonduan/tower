class EventsController < ApplicationController
  before_action :find_team, only: :index

  def index
    project_ids, calendar_ids = current_user.accessible_projects_id(@team), current_user.accessible_calendars_id(@team)
    @events = EventForm.new(p_ids: project_ids, c_ids: calendar_ids, page: params[:page]).query
    render layout: false if @is_ajax
  end

  private
  def find_team
    @team = Team.find(params[:team_id])
  end

  def is_ajax_request?
    @is_ajax = request.xhr?
  end
end
