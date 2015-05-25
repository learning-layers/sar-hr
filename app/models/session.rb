class Session < ActiveRecord::Base
  TTL = 1.hour

  after_initialize :default_values, unless: :persisted?
  after_create     :set_user_available, if: :only_alive?
  after_destroy    :set_user_offline,   if: :only_alive?

  belongs_to :user

  validates :user,       presence: true
  validates :token,      presence: true, uniqueness: true
  validates :expires_on, presence: true

  attr_readonly :token

  scope :alive,   -> { where('expires_on > ?',  Time.now) }
  scope :expired, -> { where('expires_on <= ?', Time.now) }

  # True if this session has not expired, false otherwise.
  def alive?
    expires_on > Time.now
  end

  # If the session is alive, keeps it alive until <tt>Time.now + TTL</tt>.
  def keep_alive
    alive? && update(expires_on: TTL.from_now)
  end

protected

  def default_values
    self.token      ||= generate_token
    self.expires_on ||= TTL.from_now
  end

  def generate_token
    token = Devise.friendly_token

    # Recurse to generate unique tokens only.
    if Session.exists?(token: token)
      return generate_token
    end

    token
  end

  # Returns whether this session is the user's only session alive.
  def only_alive?
    user.sessions.none? do |session|
      session != self && session.alive?
    end
  end

  def set_user_available
    user.update(status: :available)
  end

  def set_user_offline
    user.update(status: :offline)
  end
end
