module ApplicationHelper
  def current_user
    @user ||= User.create(name: 'test@mycolorway.com', password: 'foobar')
  end

  def url_helpers
    @url_helpers ||= Rails.application.routes.url_helpers
  end
end
