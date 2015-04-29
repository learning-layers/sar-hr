class User < ActiveRecord::Base
  devise :database_authenticatable, :validatable

  before_create :create_token_set!

  enum role:   [:unprivileged, :admin]
  enum status: [:offline, :available, :do_not_disturb]

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :title,      presence: true

  attr_readonly :role

  has_one  :token_set, foreign_key: :identifier, primary_key: :email,
                       dependent: :destroy

  delegate :tokens, :add_token, :remove_token, :has_token?, to: :token_set

  def name
    "#{first_name} #{last_name}"
  end
end
