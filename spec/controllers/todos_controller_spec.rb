require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  before(:all) { init_feeds }
  before(:each) { set_user_session(@user) }
  let(:actions) { %w(destroy finish assign reassign reschedule) }

  describe '#create' do
    it 'success create' do
      post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo: {title: 'foobar'}
      todo = JSON.parse(response.body)
      expect(todo['todo_list_id']).to eq(@todo_list.id)
      expect(todo['title']).to eq('foobar')
    end

    it 'failed create' do
      @user.accesses.clear
      post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo: {title: 'foobar'}
      expect(JSON.parse(response.body)).to eq(permission_denied_resp)
    end
  end

  describe '#actions' do
    it 'response success' do
      actions.each do |action|
        post action.to_sym, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id, assignee_id: @user.id
        expect(JSON.parse(response.body)).to eq(success_resp)
      end
    end

    it 'response permission denied' do
      project = create(:project, creator: @user, team: @team, project_type: Project.project_types[:standard])
      todo_list = create(:todo_list, creator: @user, project: project, list_type: TodoList.list_types[:defalut])
      todo = create(:todo, creator: create(:user), todo_list: todo_list)

      actions.each do |action|
        post action.to_sym, project_id: @project.id, todo_list_id: @todo_list.id, id: todo.id
        expect(JSON.parse(response.body)).to eq(permission_denied_resp)
      end
    end
  end
end
