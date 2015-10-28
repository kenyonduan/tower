module ApplicationHelper
  include Rails.application.routes.url_helpers

  def current_user
    @user ||= User.create(name: 'test@mycolorway.com', password: 'foobar')
  end
end
