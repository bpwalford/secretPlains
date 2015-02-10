class Fingerprint < ActiveRecord::Base

  belongs_to :user
  has_many :differences, dependent: :destroy

  serialize :plugins
  serialize :fonts

  def print
    "#{plugins}#{fonts}#{user_agent}#{browser}#{cookies}#{language}"
  end

end
