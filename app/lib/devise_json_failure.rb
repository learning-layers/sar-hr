# Overrides Devise's default failure app to produce custom JSON errors.
class DeviseJSONFailure < ActionController::API
  include Fallible

  def self.call(env)
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    render_unauthorized
  end
end
