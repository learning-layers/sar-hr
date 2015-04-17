# Overrides Devise's default failure app to produce custom JSON errors.
class DeviseJSONFailure < Devise::FailureApp
  def http_auth
    super
    self.content_type = 'application/json'
  end

  def http_auth_body
    return { :error => { :code => :unauthorized } }.to_json
  end
end
