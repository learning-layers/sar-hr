RSpec.describe ApplicationController do
  describe 'access control' do
    it { should use_before_action(:authenticate_user!) }
    it { should use_after_action(:verify_authorized) }
  end

  describe 'parameter filtering' do
    it { should filter_param(:password) }
    it { should filter_param(:token) }
  end

  describe 'exception handling' do
    it { should rescue_from(ActionController::ParameterMissing) }
    it { should rescue_from(ActiveRecord::RecordInvalid) }
    it { should rescue_from(ActiveRecord::RecordNotFound) }
    it { should rescue_from(Pundit::NotAuthorizedError) }
  end
end
