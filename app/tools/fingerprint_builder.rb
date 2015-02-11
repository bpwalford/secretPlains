class FingerprintBuilder

  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def build
    new_fingerprint = Fingerprint.new(
      user: user,
      plugins: build_plugin_matrix,
      fonts: build_font_hash,
      user_agent: params[:agent],
      browser: params[:version],
      cookies: params[:cookies],
      language: params[:language],
      screen: params[:screen],
      ip: params[:ip],
      country: params[:country],
    )
    new_fingerprint.save if altered_fingerprint?(new_fingerprint)
  end

  private

  def build_plugin_matrix
    matrix = []

    plugin_list = params[:plugins].split('||||')
    plugin_list.map{|p| p.gsub!(/\|\|\||\|\|/, '|')}
    plugin_list.map{|p| matrix << p.split('|')}

    matrix.pop

    matrix.each do |plugin|
      plugin.each_index do |i|
        plugin.delete_at(i) if plugin[i] == ''
      end
    end

    matrix
  end

  def build_font_hash
    fonts = {
      installed: [],
      uninstalled: [],
    }

    font_list = params[:fonts].split(',')

    font_list.each do |font|
      s = font.split('|')
      if s.last == 'true'
        fonts[:installed] << s.first
      else
        fonts[:uninstalled] << s.first
      end
    end

    fonts[:installed]   = fonts[:installed].uniq
    fonts[:uninstalled] = fonts[:uninstalled].uniq

    fonts
  end

  def altered_fingerprint?(new_fingerprint)
    if user.fingerprints.count == 0
      return true
    else
      last_fingerprint = user.fingerprints.last
      last_fingerprint_attrs = last_fingerprint.attributes.except('created_at', 'updated_at', 'id')
      new_fingerprint_attrs = new_fingerprint.attributes.except('created_at', 'updated_at', 'id')

      return false if last_fingerprint_attrs == new_fingerprint_attrs
    end
    true
  end

end
