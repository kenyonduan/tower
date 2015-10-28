module ApplicationHelper
  def current_user
    @user ||= User.create(name: 'test@mycolorway.com', password: 'foobar')
  end
end
