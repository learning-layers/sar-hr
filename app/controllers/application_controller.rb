class ApplicationController < ActionController::API
  include Pundit
  include Fallible

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
end
