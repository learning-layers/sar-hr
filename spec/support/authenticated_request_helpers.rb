module AuthenticatedRequestHelpers
  def get(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

  def post(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

  def patch(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

  def put(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

  def delete(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

  def head(url, options = {})
    super(url, options[:params], sign_headers(options[:headers], options[:as]))
  end

private

  def sign_headers(headers = nil, user = nil)
    headers ||= {}

    # Nothing to be done if user is nil
    return headers if user.nil?

    credential_headers = {
      'HTTP_X_USER_EMAIL' => user.email,
      'HTTP_X_USER_TOKEN' => user.sessions.create!.token
    }

    credential_headers.merge!(headers)
  end
end