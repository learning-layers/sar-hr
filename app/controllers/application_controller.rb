class ApplicationController < ActionController::API
  include Pundit
  include Fallible

  before_action :authenticate_user!

  after_action :verify_authorized,    except: :index
  after_action :verify_policy_scoped, only:   :index

  rescue_from ActionController::ParameterMissing, with: :render_missing
  rescue_from ActiveRecord::RecordInvalid,        with: :render_invalid
  rescue_from ActiveRecord::RecordNotFound,       with: :render_not_found
  rescue_from Pundit::NotAuthorizedError,         with: :render_forbidden
end
