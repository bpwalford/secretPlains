class DifferenceBuilder
  attr_reader :user, :fingerprint

  def initialize(user, fingerprint)
    @user = user
    @fingerprint = fingerprint
  end

  def build
    Difference.create!(
      user: user,
      fingerprint: fingerprint,
      plugins: calculate_plugins_diff,
      fonts: calculate_fonts_diff,
      user_agent: calculate_agent_diff,
      browser_version: fingerprint.browser_version == user.fingerprints[-2].browser_version,
      cookies: fingerprint.cookies == user.fingerprints[-2].cookies,
      language: fingerprint.language == user.fingerprints[-2].language,
      ip: fingerprint.ip == user.fingerprints[-2].ip,
      screen: fingerprint.screen == user.fingerprints[-2].screen,
      country: fingerprint.country == user.fingerprints[-2].country,
    )
  end

  private

  def calculate_plugins_diff
    total_levenshtein_distance = 0

    # this only works if the plugins stay in the same order and new plugins
    # are added onto the end, which they aren't becuase they are sorted alphabetically
    # fingerprint.plugins & user.fingerprints.plugin
    fingerprint.plugins.each_with_index do |plugins, i|
      plugins.each_index do |ii|
        old_plugins = user.fingerprints[-2].plugins

        if old_plugins[i] && old_plugins[i][ii]
          old_plugin = old_plugins[i][ii]
        else
          old_plugin = ''
        end

        new_plugin = user.fingerprints.last.plugins[i][ii]
        distance = Levenshtein.new(old_plugin, new_plugin).distance

        total_levenshtein_distance += distance
      end
    end

    total_levenshtein_distance
  end

  def calculate_fonts_diff
    new_fonts = fingerprint.fonts
    old_fonts = user.fingerprints[-2].fonts
    font_keys = fingerprint.fonts.keys

    matched = font_keys.reduce(0) do |sum, font|
      sum += 1 if new_fonts[font] == old_fonts[font]
      sum
    end

    matched.to_f/old_fonts.count.to_f
  end

  def calculate_agent_diff
    old = user.fingerprints[-2].user_agent
    now = fingerprint.user_agent
    distance = Levenshtein.new(old, now).distance
    distance
  end
end
