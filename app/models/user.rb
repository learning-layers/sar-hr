class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable

  acts_as_token_authenticatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
