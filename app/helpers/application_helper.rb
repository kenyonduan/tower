module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:user])
  end

  # TODO team 切换时需要更新数据，暂时先快速包容一下
  def current_team_id
    session[:team]
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
