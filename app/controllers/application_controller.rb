class ApplicationController < ActionController::API
  include Pundit

  before_action :authenticate_user!
  after_action  :verify_authorized

  rescue_from ActionController::ParameterMissing, with: :render_missing
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden

  protected

  # Override Pundit#authorize so we can do neat one-liners like this:
  #
  #   render json: authorize(User.all)
  #
  def authorize(record, query = nil)
    record if super(record, query)
  end

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

  def render_forbidden(error)
    body = {
      :error => {
        :code => :forbidden
      }
    }

    render json: body, status: 403
  end
end
