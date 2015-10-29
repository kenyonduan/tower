class TodosController < ApplicationController
  before_action :find_project

  def index
  end

  def new
  end

  def create
  end

  def delete
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def update

  end

  def finish
  end

  # 指派完成者
  def assign
  end

  # 修改完成者
  def reassign
  end

  # 修改完成时间
  def reschedule
  end

  private

  def find_project
    @project = Project.find(params[:project_id])
  end

  def new_todo_params
    params.require(:todo).premit(:title, :deadline, :assignee_id)
  end
end
