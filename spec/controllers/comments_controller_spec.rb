require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before(:all) { init_feeds }
  before do |example|
    unless example.metadata[:skip_before]
      set_user_session(@user)
    end
  end

  describe '#create' do
    it 'response todo comment' do
      expect {
        post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, content: 'foobar'
      }.to change(@todo.comments, :count).by(1)
      expect(JSON.parse(response.body).except!('id', 'created_at', 'updated_at')).to eq({
                                                                                            'content' => 'foobar',
                                                                                            'commentable_id' => @todo.id,
                                                                                            'commentable_type' => @todo.class.to_s,
                                                                                            'creator_id' => @user.id
                                                                                        })
    end

    it 'response todo list comment' do
      expect {
        post :create, project_id: @project.id, todo_list_id: @todo_list.id, content: 'foobar2'
      }.to change(@todo_list.comments, :count).by(1)
      expect(JSON.parse(response.body).except!('id', 'created_at', 'updated_at')).to eq({
                                                                                            'content' => 'foobar2',
                                                                                            'commentable_id' => @todo_list.id,
                                                                                            'commentable_type' => @todo_list.class.to_s,
                                                                                            'creator_id' => @user.id
                                                                                        })
    end
  end

  describe '#destroy' do
    it 'success response' do
      expect {
        delete :destroy, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, id: @todo_comment.id
      }.to change(@todo.comments, :count).by(-1)
      expect(response.body).to eq(success_resp)
    end

    it 'error response', :skip_before do
      set_user_session(create(:user))
      delete :destroy, project_id: @project.id, todo_list_id: @todo_list.id, todo_id: @todo.id, id: @todo_comment.id
      expect(response.body).to eq(permission_denied_resp)
      expect(@todo.comments).to eq([@todo_comment])
    end
  end
end
