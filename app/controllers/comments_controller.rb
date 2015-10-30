class CommentsController < ApplicationController
  before_action :find_commentable, :check_commentable_access, only: :create
  before_action :find_comment, :check_comment_access, only: :destroy

  def create
    comment = @commentable.commenting(current_user.id, params[:content])
    render json: comment # 返回 json，具体展示交由前端自己决定
  end

  def destroy
    @comment.trigger_deleted_event(current_user.id)
    render json: success_resp
  end

  private

  def find_commentable
    @commentable = if params[:todo_id]
                     Todo.find(params[:todo_id])
                   elsif params[:todo_list_id]
                     TodoList.find(params[:todo_list_id])
                   else
                     # TODO 其他拥有评论的资源(Document 等)
                   end
  end

  def check_commentable_access
    @project = Project.find(params[:project_id])
    unless current_user.accessible_projects_id(@project.team).include?(@project.id)
      render json: permission_denied_resp
    end
  end

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def check_comment_access
    # TODO 管理员也是可以删除 comment 的，前期就不考虑这个了
    render json: permission_denied_resp unless current_user.id != @comment.creator_id
  end
end
