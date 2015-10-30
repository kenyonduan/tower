require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before(:all) { init_feeds }
  before(:each) { set_user_session(@user) }

  it 'populates an array of events' do
    get :index, team_id: @team.id
    expect(assigns(:events)).to match_array(@todo.events + @todo_list.events)
    expect(response).to render_template :index
  end

  it 'visit by new user' do
    user = create(:user)
    team = create(:team, creator: user)

    get :index, team_id: team.id
    expect(assigns(:events)).to be_blank
    expect(response).to render_template :index
  end
end
