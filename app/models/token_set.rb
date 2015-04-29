class TokenSet < ActiveRecord::Base
  before_create :add_token

  serialize     :tokens, Array
  attr_readonly :tokens

  belongs_to :user, foreign_key: :identifier, primary_key: :email
  validates  :identifier, presence: true

  def add_token
    token = generate_token
    tokens << token
    token
  end

  def remove_token(token)
    tokens.delete(token)
  end

  def has_token?(token)
    # Using Devise#secure_compare for constant-time comparison to mitigate
    # timing attacks.
    tokens.any? { |t| Devise.secure_compare(t, token) }
  end

  protected

  def generate_token
    token = Devise.friendly_token

    # Recurse to generate unique tokens only
    if tokens.include?(token)
      return generate_token
    end

    token
  end
end
