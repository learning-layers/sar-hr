class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable

  acts_as_token_authenticatable

  enum role:   [:unprivileged, :admin]
  enum status: [:offline, :available, :do_not_disturb]

  validates :first_name, presence: true
  validates :last_name, presence: true

  attr_readonly :role

  def name
    "#{first_name} #{last_name}"
  end
end
