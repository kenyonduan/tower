class TodosController < ApplicationController
  before_action :check_project_access, only: :create
  before_action :find_todo, except: :create
  before_action :check_todo_access, except: :create

  def create
    todo = Todo.create(todo_params.merge(creator: current_user, todo_list_id: params[:todo_list_id]))
    render json: todo
  end

  def destroy
    # TODO: 删除权限控制(creator、manager) 不能越级删除
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
    params.require(:todo).permit(:title, :description, :deadline, :status, :assignee_id)
  end

  def find_todo
    @todo = Todo.find(params[:id])
  end

  def check_todo_access
    if current_user.id != @todo.creator_id # 创建者就一定有权限
      render json: permission_denied_resp unless current_user.accessible_projects_id.include?(@todo.todo_list.project_id)
    end
  end

  def check_project_access
    unless current_user.accessible_projects_id.include?(params[:project_id])
      render json: permission_denied_resp
    end
  end
end
