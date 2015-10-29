class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    comment = @commentable.commenting(current_user.id, params[:content])
    render json: comment # 返回 json，具体展示交由前端自己决定
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
end
