class User < ApplicationRecord
	# overrides rails attributes, remove
	# attr_accessor :firstName, :lastName, :userType, :username, :
	has_and_belongs_to_many :notifications
  
	before_save { username.downcase! } 
	#self.username = self.username.downcase 

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }
	validates :user_type, presence: true, inclusion: { in: %w(admin client staff) }
	validates :username, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6, maximum: 50 }

	has_secure_password

	# Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
