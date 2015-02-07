class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :email, :password
  validates_uniqueness_of :email

  has_many :fingerprints
  has_many :differences

  def email_to_username
    chars = self.email.split("")
    break_point = chars.index("@")
    username = chars[0..break_point-1].join
  end

end
