class User < ActiveRecord::Base
  has_one :role
  
  enum profile: [:print, :crea, :manager]
  
  has_many :projects
  attr_accessor :remember_token
  
  has_secure_password
  
  validates :login, presence: true,
                    uniqueness: true
  validates :password, presence: true,
                       length: {minimum: 5},
                       allow_nil: true
                       
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
 def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
    
  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
