class DifferenceBuilder
  attr_reader :calculator

  def initialize(calculator)
    @calculator = calculator
  end

  def build
    Difference.create!(
      original: calculator.original,
      altered: calculator.altered,
      plugins_intersection: calculator.plugins_intersection,
      plugins_lev: calculator.plugins_distance,
      user_agent_intersection: calculator.user_agent_intersection,
      user_agent_lev: calculator.user_agent_distance,
      browser_intersection: calculator.browser_intersection,
      browser_lev: calculator.browser_distance,
      fonts_intersection: calculator.fonts_intersection,
      original_to_altered_font_match: calculator.original_to_altered_font_match,
      altered_to_original_font_match: calculator.altered_to_original_font_match,
      cookies: calculator.cookies,
      language: calculator.language,
      ip: calculator.ip,
      screen: calculator.screen,
      country: calculator.country,
    )
  end
end
