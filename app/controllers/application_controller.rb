class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token

  before_action :authenticate

  private

  rescue_from ActionController::ParameterMissing do |error|
    render json: missing_parameter(error), status: 422
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: invalid_parameters(error), status: 422
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: not_found(error), status: 404
  end

  def authenticate
    current_user || render_unauthorized
  end

  def current_user
    User.find_by(auth_token: token_and_options(request))
  end

  def render_unauthorized
    headers['WWW-Authenticate'] = 'Token realm="Heureka"'
    render json: unauthorized, status: 401
  end

  def missing_parameter(error)
    {
      :error => {
        :code => :missing_parameter,
        :parameters => {
          error.param => 'required'
        }
      }
    }
  end

  def invalid_parameters(error)
    {
      :error => {
        :code => :invalid_parameters,
        :parameters => error.record.errors
      }
    }
  end

  def not_found(error)
    {
      :error => {
        :code => :not_found
      }
    }
  end

  def unauthorized
    {
      :error => {
        :code => :unauthorized
      }
    }
  end
end
