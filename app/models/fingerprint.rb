class Fingerprint < ActiveRecord::Base

  belongs_to :user

  serialize :plugins
  serialize :fonts

  def print
    "#{plugins}#{fonts}#{user_agent}#{browser_version}#{cookies}#{language}"
  end

end
