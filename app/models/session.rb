class Session < ActiveRecord::Base
  TTL = 1.hour

  after_initialize :default_values, unless: :persisted?
  after_create     :set_user_available, if: :only_alive?
  after_destroy    :set_user_offline, if: :only_alive?

  belongs_to :user

  validates :user,       presence: true
  validates :token,      presence: true, uniqueness: true
  validates :expires_on, presence: true

  attr_readonly :token

  # Fetch alive sessions only
  scope :alive, -> { where('expires_on > ?', Time.now) }

  # Fetch expired sessions only
  scope :expired, -> { where('expires_on <= ?', Time.now) }

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

  def only_alive?
    user.sessions.none? do |session|
      session != self && session.alive?
    end
  end

  def set_user_available
    user.update!(status: :available)
  end

  def set_user_offline
    user.update!(status: :offline)
  end
end
