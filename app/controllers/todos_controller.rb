class TodosController < ApplicationController
  before_action :find_todo_list, only: :create
  before_action :check_project_access, only: :create
  before_action :find_todo, except: :create
  before_action :check_todo_access, except: :create


  def create
    todo = Todo.create(todo_params.merge(creator: current_user, todo_list: @todo_list))
    render json: todo
  end

  def delete
    @todo.trigger_deleted_event(current_user.id)
    render json: success_resp
  end

  def finish
    @todo.trigger_finished_event(current_user.id)
    render json: success_resp
  end

  # 指派完成者
  def assign
    @todo.trigger_assign_event(current_user.id, params[:assignee_id])
    render json: success_resp
  end

  # 修改完成者
  def reassign
    @todo.trigger_reassign_event(current_user.id, params[:assignee_id])
    render json: success_resp
  end

  # 修改完成时间
  def reschedule
    @todo.trigger_reschedule_event(current_user.id, params[:deadline])
    render json: success_resp
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :deadline, :status, :assignee_id, :todo_list_id)
  end

  def find_todo_list
    @todo_list = if params[:todo_list_id]
                   TodoList.find(params[:todo_list_id])
                 else
                   Project.find(params[:project_id]).default_todo_list
                 end
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def check_todo_access
    unless current_user.accessible_projects_id.include?(@todo.todo_list.project_id)
      render json: permission_denied_resp
    end
  end

  def check_project_access
    unless current_user.accessible_projects_id.include?(params[:project_id])
      render json: permission_denied_resp
    end
  end
end
