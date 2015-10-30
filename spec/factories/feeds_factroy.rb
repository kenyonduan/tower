module FeedsFactroy
  # 统一创建基础的 model
  def init_feeds
    # user
    @user = create(:user)
    # team
    @team = create(:team, creator: @user)
    # project
    @project = create(:project, creator: @user, team: @team, project_type: Project.project_types[:standard])
    # todo_list
    @todo_list = create(:todo_list, creator: @user, project: @project, list_type: TodoList.list_types[:defalut])
    # todo
    @todo = create(:todo, creator: @user, todo_list: @todo_list)
    # comment
    @todo_comment = create(:comment, creator: @user, commentable: @todo)
    @todo_list_comment = create(:comment, creator: @user, commentable: @todo_list)
  end
end