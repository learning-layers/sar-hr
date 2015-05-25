# Responsible for associating users with temporary tokens that can be used
# for authenticating for a limited time and then invalidated.
#
# == Examples
#
#    User.find_by_email(email).valid_token?(token)  # returns true/false
#
module TokenAuthenticatable
  extend ActiveSupport::Concern

  included do
    has_many :sessions, dependent: :destroy
  end

  # Verifies whether the given token corresponds to a valid session.
  def valid_token?(token)
    sessions.any? do |session|
      # Using Devise.secure_compare for constant-time comparison to protect
      # against timing attacks.
      Devise.secure_compare(session.token, token) && session.alive?
    end
  end
end
