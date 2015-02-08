class DifferenceBuilder
  attr_reader :calculater

  def initialize(calculator)
    @calculater = calculator
  end

  def build
    Difference.create!(
      original_id: calculater.original,
      altered_id: calculater.altered,
      plugins_intersection: calculater.plugins_intersection,
      plugins_lev: calculater.plugins_distance,
      user_agent_intersection: calculater.user_agent_intersection,
      user_agent_lev: calculater.user_agent_distance,
      browser_intersection: calculater.browser_intersection,
      browser_lev: calculater.browser_distance,
      fonts_intersection: calculater.fonts_intersection,
      percent_font_match: calculater.percent_font_match,
      cookies: calculater.cookies,
      language: calculater.language,
      ip: calculater.ip,
      screen: calculater.screen,
      country: calculater.country,
    )
  end
end
