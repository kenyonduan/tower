class CommentsController < ApplicationController
  before_action :find_commentable

  def create
    comment = @commentable.commenting(current_user.id, params[:content])
    render json: comment.to_json # 返回 json，具体展示交由前端自己决定
  end

  private

  def find_commentable
    @commentable = if params[:todo_id]
                     Todo.find(params[:todo_id])
                   else
                     # TODO 其他拥有评论的资源(Document 等)
                   end
  end
end
