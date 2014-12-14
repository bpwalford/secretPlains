class User < ActiveRecord::Base

  validates_presence_of :email

  def email_to_username
    chars = self.email.split("")
    break_point = chars.index("@")
    chars = chars[0..break_point-1]

    username = chars.join
  end

end
