class Difference < ActiveRecord::Base

  serialize :plugins_intersection
  serialize :user_agent_intersection
  serialize :browser_intersection
  serialize :font_intersection

  belongs_to :original, class_name: 'Fingerprint'
  belongs_to :altered,  class_name: 'Fingerprint'

end
