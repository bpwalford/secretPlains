class Fingerprint < ActiveRecord::Base

  belongs_to :user
  has_one :difference, dependent: :destroy

  serialize :plugins
  serialize :fonts

  def print
    "#{plugins}#{fonts}#{user_agent}#{browser_version}#{cookies}#{language}"
  end

end
