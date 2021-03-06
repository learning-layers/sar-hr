Warden::Strategies.add(:token_authentication) do
  def valid?
    email && token
  end

  def authenticate!
    user = User.find_by_email(email)

    if user && user.valid_token?(token)
      keep_token_alive(user, token)
      success!(user)
    else
      fail
    end
  end

protected

  def email
    request.headers['HTTP_X_USER_EMAIL']
  end

  def token
    request.headers['HTTP_X_USER_TOKEN']
  end

  def keep_token_alive(user, token)
    user.sessions.find_by_token(token).keep_alive
  end
end
