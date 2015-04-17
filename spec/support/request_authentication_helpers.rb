module RequestAuthenticationHelpers
  def get_with_auth(path, params = nil, headers = nil, options = {})
    get path, params, headers_with_auth(headers, options[:user])
  end

  def post_with_auth(path, params = nil, headers = nil, options = {})
    post path, params, headers_with_auth(headers, options[:user])
  end

  def patch_with_auth(path, params = nil, headers = nil, options = {})
    patch path, params, headers_with_auth(headers, options[:user])
  end

  def put_with_auth(path, params = nil, headers = nil, options = {})
    put path, params, headers_with_auth(headers, options[:user])
  end

  def delete_with_auth(path, params = nil, headers = nil, options = {})
    delete path, params, headers_with_auth(headers, options[:user])
  end

  def head_with_auth(path, params = nil, headers = nil, options = {})
    head path, params, headers_with_auth(headers, options[:user])
  end

  def headers_with_auth(headers = nil, user = nil)
    headers ||= {}
    user ||= create(:user)

    credential_headers = {
      'HTTP_X_USER_EMAIL' => user.email,
      'HTTP_X_USER_TOKEN' => user.authentication_token
    }

    credential_headers.merge!(headers)
  end
end
