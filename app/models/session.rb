class Session < ActiveRecord::Base
  after_initialize :default_values

  belongs_to :user

  validates :user,       presence: true
  validates :token,      presence: true, uniqueness: true
  validates :expires_on, presence: true

  attr_readonly :token

  def alive?
    expires_on > Time.now
  end

protected

  def default_values
    self.token      ||= generate_token
    self.expires_on ||= 1.hour.from_now
  end

  def generate_token
    token = Devise.friendly_token

    # Recurse to generate unique tokens only
    if Session.find_by_token(token)
      generate_token
    else
      token
    end
  end
end
