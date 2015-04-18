class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback_to_devise: false

  before_action :authenticate_user!

  rescue_from ActionController::ParameterMissing, with: :render_missing
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  private

  # TODO: Use serialisers

  def render_missing(error)
    body = {
      :error => {
        :code => :missing_parameter,
        :parameters => {
          error.param => 'required'
        }
      }
    }

    render json: body, status: 422
  end

  def render_invalid(error)
    body = {
      :error => {
        :code => :invalid_parameters,
        :parameters => error.record.errors
      }
    }

    render json: body, status: 422
  end

  def render_not_found(error)
    body = {
      :error => {
        :code => :not_found
      }
    }

    render json: body, status: 404
  end
end
