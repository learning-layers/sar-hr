#
# Common failure helpers for controllers and the failure app.
#
module Fallible
  extend ActiveSupport::Concern

protected

  def render_missing(parameter_missing_error)
    body = {
      error: {
        code: :missing_parameter,
        parameters: {
          parameter_missing_error.param => :required
        }
      }
    }

    render json: body, status: 422
  end

  def render_invalid(record_invalid_error)
    body = {
      error: {
        code: :invalid_parameters,
        parameters: record_invalid_error.record.errors
      }
    }

    render json: body, status: 422
  end

  def render_not_found
    body = {
      error: {
        code: :not_found
      }
    }

    render json: body, status: 404
  end

  def render_forbidden
    body = {
      error: {
        code: :forbidden
      }
    }

    render json: body, status: 403
  end

  def render_unauthorized
    body = {
      error: {
        code: :unauthorized
      }
    }

    render json: body, status: 401
  end
end
