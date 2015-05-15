class Session < ActiveRecord::Base
  TTL = 1.hour

  after_initialize :default_values, unless: :persisted?

  belongs_to :user

  validates :user,       presence: true
  validates :token,      presence: true, uniqueness: true
  validates :expires_on, presence: true

  attr_readonly :token

  def alive?
    expires_on > Time.now
  end

  def keep_alive
    alive? && update!(expires_on: TTL.from_now)
  end

protected

  def default_values
    self.token      ||= generate_token
    self.expires_on ||= TTL.from_now
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
