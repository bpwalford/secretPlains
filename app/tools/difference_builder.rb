class DifferenceBuilder
  attr_reader :original, :altered

  def initialize(original, altered)
    @original = original
    @altered = altered
  end

  def build
    Difference.create!(
      original_id: original,
      altered_id: altered,
      plugins_intersection:
        (original.plugins.flatten & altered.plugins.flatten),
      plugins_lev: plugin_lev,
      user_agent_intersection:
        original.user_agent.split(' ') & altered.user_agent.split(' '),
      user_agent_lev:
        Levenshtein.new.distance(
          original.user_agent,
          altered.user_agent
        ),
      browser_intersection:
        original.browser_version.split(' ') & altered.browser_version.split(' '),
      browser_lev:
        Levenshtein.new.distance(
          original.browser_version,
          altered.browser_version
        ),
      fonts_intersection: fonts_intersection,
      percent_font_match: fonts_match,
      cookies: original.cookies == altered.cookies,
      language: original.language == altered.language,
      ip: original.ip == altered.ip,
      screen: original.screen == altered.screen,
      country: original.country == altered.country,
    )
  end

  private

  def plugin_lev
    intersection = original.plugins.flatten & altered.plugins.flatten
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

    Levenshtein.new.distance(first, second)
  end

  def fonts_intersection
    persisted_fonts = original.fonts[:installed] - altered.fonts[:uninstalled]
  end

  def fonts_match
    new_fonts = altered.fonts[:installed].length
    matched = 0

    original.fonts[:installed].each do |font|
      matched += 1 if altered.fonts[:installed].include?(font)
    end

    matched.to_f/new_fonts.to_f
  end

end
