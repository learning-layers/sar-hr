Warden::Strategies.add(:token_authentication) do
  def valid?
    identifier && token
  end

  def authenticate!
    token_set = TokenSet.find_by_identifier(identifier)

    if token_set && token_set.has_token?(token)
      success!(token_set.user)
    else
      fail
    end
  end

  protected

  def identifier
    request.headers['HTTP_X_USER_EMAIL']
  end

  def token
    request.headers['HTTP_X_USER_TOKEN']
  end
end
