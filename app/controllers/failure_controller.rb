# Overrides Devise's default failure app to produce custom JSON errors.
class FailureController < ActionController::API
  include Fallible

  def self.call(env)
    # Always use the :respond action.
    @respond ||= action(:respond)
    @respond.call(env)
  end

  def respond
    render_unauthorized
  end
end
