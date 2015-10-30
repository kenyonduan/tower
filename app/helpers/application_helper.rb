module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user])
  end

  def url_helpers
    @url_helpers ||= Rails.application.routes.url_helpers
  end

  def success_resp
    @success_resp ||= {status: 'success'}
  end

  def permission_denied_resp
    @permission_denied_resp ||= {status: 'error', message: '没有权限!'}
  end
end
