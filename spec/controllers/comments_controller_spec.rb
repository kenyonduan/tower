require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:all) { init_feeds }
  before(:each) { set_user_session(@user) }

  it 'response todo comment' do
    post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, content: 'foobar'
    expect(JSON.parse(response.body)['commentable_type']).to eq('Todo')
  end

  it 'response todo list comment' do
    post :create, project_id: @project.id, todo_list_id: @todo_list.id, content: 'foobar2'
    expect(JSON.parse(response.body)['commentable_type']).to eq('TodoList')
  end
end
