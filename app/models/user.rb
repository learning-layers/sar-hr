class User < ActiveRecord::Base
  include TokenAuthenticatable
  devise :database_authenticatable, :validatable

  has_and_belongs_to_many :skills

  enum role:   [:unprivileged, :admin]
  enum status: [:offline, :available, :do_not_disturb]

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :title,      presence: true

  attr_readonly :role

  def name
    "#{first_name} #{last_name}"
  end
end
