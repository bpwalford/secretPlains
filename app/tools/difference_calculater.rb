class DifferenceCalculater
  attr_reader :distance_calculator
  attr_accessor :original, :altered

  def initialize(original, altered, distance_calculator)
    @original = original
    @altered = altered
    @distance_calculator = distance_calculator
  end

  def plugins_intersection
    original.plugins.flatten & altered.plugins.flatten
  end

  def plugins_lev
    intersection = plugins_intersection
    original_diffs = (original.plugins.flatten - intersection)
    altered_diffs  = (altered.plugins.flatten - intersection)

    first = ''
    original_diffs.each do |plugin|
      first +=  plugin
    end

    second = ''
    altered_diffs.each do |plugin|
      second += plugin
    end

    distance_calculator.distance(first, second)
  end

  def user_agent_intersection
    original.user_agent.split(' ') & altered.user_agent.split(' ')
  end

  def user_agent_lev
    distance_calculator.distance(original.user_agent, altered.user_agent)
  end

  def browser_intersection
    original.browser_version.split(' ') & altered.browser_version.split(' ')
  end

  def browser_lev
    distance_calculator.distance(original.browser_version, altered.browser_version)
  end

  def fonts_intersection
    persisted_fonts = original.fonts[:installed] - altered.fonts[:uninstalled]
  end

  def percent_font_match
    new_fonts = altered.fonts[:installed].length
    matched = 0

    original.fonts[:installed].each do |font|
      matched += 1 if altered.fonts[:installed].include?(font)
    end

    matched.to_f/new_fonts.to_f
  end

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
