class User < ActiveRecord::Base
  before_create :set_auth_token

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  private

  def set_auth_token
    self.auth_token = generate_token
  end

  def generate_token
    SecureRandom.uuid.gsub(/\-/,'')
  end
end
