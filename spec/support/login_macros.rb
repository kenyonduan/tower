module LoginMacros
  def set_user_session(user)
    session[:user] = user.id
  end
end