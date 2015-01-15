class User < ActiveRecord::Base

  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :fingerprints

  def email_to_username
    chars = self.email.split("")
    break_point = chars.index("@")
    username = chars[0..break_point-1].join
  end

end
