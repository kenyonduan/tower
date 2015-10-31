require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:all) { init_feeds }
  before(:each) { set_user_session(@user) }

  describe '#create' do
    it 'response todo comment' do
      post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, content: 'foobar'
      expect(JSON.parse(response.body)['commentable_type']).to eq('Todo')
    end

    it 'response todo list comment' do
      post :create, project_id: @project.id, todo_list_id: @todo_list.id, content: 'foobar2'
      expect(JSON.parse(response.body)['commentable_type']).to eq('TodoList')
    end
  end

  describe '#destroy' do
    it 'success response' do
      delete :destroy, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, id: @todo_comment.id
      expect(JSON.parse(response.body)['status']).to eq('success')
    end

    it 'error response' do
      comment = create(:comment, creator: create(:user), commentable: @todo)
      delete :destroy, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, id: comment.id
      expect(JSON.parse(response.body)).to eq(permission_denied_resp)
    end
  end
end
