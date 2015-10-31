require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  before(:all) { init_feeds }
  before do |example|
    unless example.metadata[:skip_before]
      set_user_session(@user)
    end
  end
  let(:date) { Time.parse('2015-10-30').to_date }

  describe '#create' do

    it 'success create' do
      expect {
        post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo: {title: 'foo', description: 'bar', deadline: date, assignee_id: @user.id}
      }.to change(@todo_list.todos, :count).by(1)
      expect(JSON.parse(response.body).except!('id', 'created_at', 'updated_at')).to eq({
                                                                                            'title' => 'foo',
                                                                                            'description' => 'bar',
                                                                                            'deadline' => date.to_s,
                                                                                            'status' => nil,
                                                                                            'creator_id' => @user.id,
                                                                                            'assignee_id' => @user.id,
                                                                                            'todo_list_id' => @todo_list.id
                                                                                        })
    end

    it 'create failed', :skip_before do
      set_user_session(create(:user))
      post :create, project_id: @project.id, todo_list_id: @todo_list.id, todo: {title: 'foo', description: 'bar', deadline: date, assignee_id: @user.id}
      expect(response.body).to eq(permission_denied_resp)
      expect(@todo_list.todos).to eq([@todo])
    end
  end

  describe '#actions' do
    let(:match_status) {
      {
          destroy: 'deleted',
          finish: 'finished',
          assign: 'assignee_id',
          reassign: 'assignee_id',
          reschedule: 'deadline'
      }
    }
  end

  it 'should be deleted' do
    expect {
      post :destroy, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id
    }.to change(@todo.events, :count).by(1)
    expect(response.body).to eq(success_resp)
    # 检查是否更改了状态
    expect(@todo.reload).to be_deleted
  end

  it 'should be finished' do
    expect {
      post :finish, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id
    }.to change(@todo.events, :count).by(1)
    expect(response.body).to eq(success_resp)
    expect(@todo.reload).to be_finished
  end

  it 'should be assign to user' do
    expect {
      post :assign, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id, assignee_id: @user.id
    }.to change(@todo.events, :count).by(1)
    expect(response.body).to eq(success_resp)
    expect(@todo.reload.assignee).to eq(@user)
  end

  it 'should be reassign to user2' do
    user2 = create(:user, accesses: [@access])
    expect {
      post :assign, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id, assignee_id: user2.id
    }.to change(@todo.events, :count).by(1)
    expect(response.body).to eq(success_resp)
    expect(@todo.reload.assignee).to eq(user2)
  end

  it 'should reschedule to date' do
    expect {
      post :reschedule, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id, deadline: date
    }.to change(@todo.events, :count).by(1)
    expect(response.body).to eq(success_resp)
    expect(@todo.reload.deadline).to eq(date)
  end

  it 'response permission denied', :skip_before do
    set_user_session(create(:user))
    [:destroy, :finish, :assign, :reassign, :reschedule].each do |action|
      expect {
        post action, project_id: @project.id, todo_list_id: @todo_list.id, id: @todo.id, assignee_id: @user.id
      }.not_to change(@todo.events, :count).from(2) # 原本有两个 Event(分别是 @todo 创建、@todo_comment 创建)
      expect(response.body).to eq(permission_denied_resp)
    end
  end
end
