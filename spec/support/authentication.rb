module AuthenticationHelpers
  def authenticate(user = create(:user))
    if user.present?
      controller.request.env['HTTP_AUTHORIZATION'] = token_header(user)
    end
  end

  private

  def token_header(user)
    "Token token=#{user.auth_token}"
  end
end
