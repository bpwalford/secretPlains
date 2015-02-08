require 'calculator_components/intersection_calculater'
require 'calculator_components/distance_calculater'

class DifferenceCalculater

  include IntersectionCalculater
  include DistanceCalculater

  attr_reader :distance_method
  attr_accessor :original, :altered

  def initialize(original, altered, distance_method)
    @original = original
    @altered = altered
    @distance_method = distance_method
  end

# intersections
# ***************************************************************************
  def plugins_intersection
    calculate_intersection(original.plugins, altered.plugins)
  end

  def user_agent_intersection
    calculate_intersection(original.user_agent, altered.user_agent)
  end

  def browser_intersection
    calculate_intersection(original.browser_version, altered.browser_version)
  end

  def fonts_intersection
    calculate_intersection(original.fonts[:installed], altered.fonts[:installed])
  end

# distance measurments
# ***************************************************************************
  def plugins_distance
    intersection = plugins_intersection
    calculate_distance(
      original.plugins,
      altered.plugins,
      intersection,
      distance_method
    )
  end

  def user_agent_distance
    intersection = user_agent_intersection
    calculate_distance(
      original.user_agent.split(' '),
      altered.user_agent.split(' '),
      intersection,
      distance_method
    )
  end

  def browser_distance
    intersection = browser_intersection
    calculate_distance(
      original.browser_version.split(' '),
      altered.browser_version.split(' '),
      intersection,
      distance_method
    )
  end

# percent calculations
# ***************************************************************************
  def percent_font_match
    new_fonts = altered.fonts[:installed].length
    matched = 0

    original.fonts[:installed].each do |font|
      matched += 1 if altered.fonts[:installed].include?(font)
    end

    matched.to_f/new_fonts.to_f
  end

# boolean matched
# ***************************************************************************
  def cookies
    original.cookies == altered.cookies
  end

  def language
    original.language == altered.language
  end

  def ip
    original.ip == altered.ip
  end

  def screen
    original.screen == altered.screen
  end

  def country
    original.country == altered.country
  end
end
