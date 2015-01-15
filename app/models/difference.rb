class Difference < ActiveRecord::Base

  belongs_to :fingerprint
  belongs_to :user

end
