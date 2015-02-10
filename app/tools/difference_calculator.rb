require 'calculator_components/intersection_calculator'
require 'calculator_components/distance_calculator'
require 'calculator_components/percent_match_calculator'

class DifferenceCalculator

  include IntersectionCalculator
  include DistanceCalculator
  include PercentMatchCalculator

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
    calculate_intersection(original.browser, altered.browser)
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
      original.browser.split(' '),
      altered.browser.split(' '),
      intersection,
      distance_method
    )
  end

# percent calculations
# ***************************************************************************
  def original_to_altered_font_match
    percent_match(original.fonts[:installed], altered.fonts[:installed])
  end

  def altered_to_original_font_match
    percent_match(altered.fonts[:installed], original.fonts[:installed])
  end

# boolean matches
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
