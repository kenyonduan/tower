class ProjectsController < ApplicationController
  def create
    Project.create(new_project_params)
  end

  private
  def new_project_params
    params.require(:project).permit(:name, :description, :guest_lockable, :project_type)
  end
end
