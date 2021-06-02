class User < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 3}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  def self.authenticate_with_credentials(email, password)
    email = email.gsub(/\s+/, "")
    user = User.find_by("LOWER(email)= ?", email.downcase)

    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end
  
end
