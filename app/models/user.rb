# == Schema Information
# Schema version: 20110521031917
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

# == Schema Information
# Schema version: 20110516195437
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  first_name         :string(255)
#  last_name          :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

class User < ActiveRecord::Base
  attr_accessor   :password
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :first_name, :presence     => true,
					     :length       => { :maximum => 50 }
  validates :last_name,  :presence     => true,
					     :length       => { :maximum => 50 }
  validates :email, 	 :presence     => true,
					     :format       => { :with => email_regex },
					     :uniqueness   => { :case_sensitive => false }
  validates :password,   :presence     => true,
					     :confirmation => true,
					     :length       => { :within => 6..12 }
  
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  
  def User.authenticate(email, submitted_password)
    user = User.find_by_email(email)
	return nil  if user.nil?
	return user if user.has_password?(submitted_password)
  end
  
  def User.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
	(user && user.salt == cookie_salt) ? user : nil
  end
  
  private
  
    def encrypt_password
	  self.salt = make_salt if new_record?
	  self.encrypted_password = encrypt(password)
	end
	
	def encrypt(string)
	  secure_hash("#{salt}--#{string}") 
	end
	
	def make_salt
	  secure_hash("#{Time.now.utc}--#{password}")
	end
	
	def secure_hash(string)
	  Digest::SHA2.hexdigest(string)
	end
end
