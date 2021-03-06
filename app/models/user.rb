class User < ApplicationRecord
  before_save { self.username = username.downcase }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_and_belongs_to_many :groups
  has_and_belongs_to_many :notifications
  has_and_belongs_to_many :events

  validates :username, presence: true, length: { maximum: 50 }, uniqueness: {
    case_sensitive: false
  }
  validates :email, uniqueness: true
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :user_type, presence: true

  # Per the instructions to be able to user username as key for authentication
  # https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-with-something-other-than-their-email-address

  def email_required?
    false
  end

  # use this instead of email_changed? for rails >= 5.1
  def will_save_change_to_email?
    false
  end

  def active_for_authentication?
    super && !deactivated
  end
end
