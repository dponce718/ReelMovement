class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :reset_token 
	 before_save { email.downcase! }
   before_create :create_activation_digest

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 250 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }


  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment_content_type :avatar, :content_type => /^image\/(png|gif|jpeg|jpg)/

  validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]
  



 def send_password_reset_email
       UserMailer.password_reset(self).deliver_now
   end

#sets the password reset attributes
   def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest, User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
   end
   
 # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end 


  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #returns true if the given token matches the digest
   def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
 # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # sends activation email
  def send_activation_email
       UserMailer.account_activation(self).deliver_now
   end
 
      
  #activates an account
  def activate
    self.update_attribute(:activated,    true)
    self.update_attribute(:activated_at, Time.zone.now)
   end 



private
  
  def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
  end  







