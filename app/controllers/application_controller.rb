class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :authenticate_user!

  rescue_from ActionController::ParameterMissing do |error|
    render json: missing_parameter(error), status: 422
  end

  rescue_from ActiveRecord::RecordInvalid do |error|
    render json: invalid_parameters(error), status: 422
  end

  rescue_from ActiveRecord::RecordNotFound do |error|
    render json: not_found(error), status: 404
  end

  private

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
