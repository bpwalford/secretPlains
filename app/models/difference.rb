class Difference < ActiveRecord::Base

  serialize :plugins_intersection
  serialize :user_agent_intersection
  serialize :browser_intersection
  serialize :fonts_intersection

  belongs_to :original, class_name: 'Fingerprint'
  belongs_to :altered,  class_name: 'Fingerprint'

end
