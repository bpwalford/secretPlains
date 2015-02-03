require 'rails_helper'

describe DifferenceBuilder do

  before do
    @user = create_user
    @original = create_fingerprint(
      user: @user
    )
  end

  context 'plugins:' do

    context 'existing plugins are altered' do

      it 'gets levenshtein when full plugin removed' do
        altered = create_fingerprint(
          plugins: [ ['plugin_one', 'v 1.0.0', 'asdf !@#$'] ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(17)
      end

      it 'gets intersection when full plugin removed' do
        altered = create_fingerprint(
          plugins: [ ['plugin_one', 'v 1.0.0', 'asdf !@#$'] ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_intersection).to eq(
          ['plugin_one', 'v 1.0.0', 'asdf !@#$']
        )
      end

      it 'gets levenshtein when plugin attributes change' do
        altered = create_fingerprint(
          plugins: [
            ['plg_one', 'v 1.0.0', 'asdf new !@#$'],
            ['plugin_two', 'v 3.5.3']
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(7)
      end

      it 'gets intersection when plugin attributes change' do
        altered = create_fingerprint(
          plugins: [
            ['plg_one', 'v 1.0.0', 'asdf new !@#$'],
            ['plugin_two', 'v 3.5.3']
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        matched = intersection_match?(
          diff.plugins_intersection,
          ['plugin_two', 'v 3.5.3', 'v 1.0.0']
        )
        expect(matched).to eq(true)
      end

      it 'get levenshtein when plugin index changes' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_two', 'v 3.5.3'],
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(0)
      end

      it 'gets intersection when plugin index changes' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_two', 'v 3.5.3'],
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        matched = intersection_match?(
          diff.plugins_intersection,
          ['plugin_two', 'v 3.5.3', 'plugin_one', 'v 1.0.0', 'asdf !@#$']
        )
        expect(matched).to eq(true)
      end

    end

    context 'new plugins added' do

      it 'gets levenshtein when added to the end' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_two', 'v 3.5.3'],
            ['plugin_thr', 'v 1.0']
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(15)
      end

      it 'gets intersection when added to the end' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_two', 'v 3.5.3'],
            ['plugin_thr', 'v 1.0']
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        matched = intersection_match?(
          diff.plugins_intersection,
          ['plugin_two', 'v 3.5.3', 'plugin_one', 'v 1.0.0', 'asdf !@#$']
        )
        expect(matched).to eq(true)
      end

      it 'gets levenshtein when added to beginning' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_thr', 'v 1.0'],
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_two', 'v 3.5.3']
          ],
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(15)
      end

      it 'gets intersection when added to beginning' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_thr', 'v 1.0'],
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_two', 'v 3.5.3']
          ],
        )
        diff = DifferenceBuilder.new(@original, altered).build
        matched = intersection_match?(
          diff.plugins_intersection,
          ['plugin_two', 'v 3.5.3', 'plugin_one', 'v 1.0.0', 'asdf !@#$']
        )
        expect(matched).to eq(true)
      end

      it 'gets levenshtein when added to middle' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_thr', 'v 1.0'],
            ['plugin_two', 'v 3.5.3']
          ],
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(15)
      end

      it 'gets intersection when added to middle' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_one', 'v 1.0.0', 'asdf !@#$'],
            ['plugin_thr', 'v 1.0'],
            ['plugin_two', 'v 3.5.3']
          ]
        )
        diff = DifferenceBuilder.new(@original, altered).build
        matched = intersection_match?(
          diff.plugins_intersection,
          ['plugin_two', 'v 3.5.3', 'plugin_one', 'v 1.0.0', 'asdf !@#$']
        )
        expect(matched).to eq(true)
      end

    end

    context 'test\'s test' do

      it 'is accurate with every possible alteration' do
        altered = create_fingerprint(
          plugins: [
            ['plugin_thr'],
            ['plugin', 'v 3.5.3'],
            ['plugin_fou'],
            ['plugin_one', 'v 1.0.1'],
            ['plugin_fiv'],
          ],
        )
        diff = DifferenceBuilder.new(@original, altered).build
        expect(diff.plugins_lev).to eq(34)
        matched = intersection_match?(
          diff.plugins_intersection,
          ['v 3.5.3', 'plugin_one']
        )
        expect(matched).to eq(true)
      end

    end

  end


  context 'attributes other than plugins' do

    it 'gets the intersection for user agent' do
      altered = create_fingerprint(
      # 'user_agent, browser, v1.2.3 %%'
        user_agent: 'user_agent, browser52, v1.2.3 %%asdf'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      matched = intersection_match?(
        diff.user_agent_intersection,
        ['user_agent,', 'v1.2.3']
      )
      expect(matched).to eq(true)
    end

    it 'gets the levenshtein distance for the user agent' do
      altered = create_fingerprint(
        user_agent: 'user_agent, browser52, v1.2.3, %%asdf '
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.user_agent_lev).to eq(8)
    end

    it 'gets the intersection for browser version' do
      altered = create_fingerprint(
        browser_version: 'versSion 1.3ba.6 % !%'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.browser_intersection).to eq(['1.3ba.6'])
    end

    it 'gets the the levenshtein distance for the browser version' do
      altered = create_fingerprint(
        browser_version: 'versSion 1.3ba.6 % !%'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.browser_lev).to eq(3)
    end

    it 'gets the intersection of fonts' do
      altered = create_fingerprint(
        fonts: {
          installed:   ['font1', 'font2', 'font6', 'font5'],
          uninstalled: ['font4', 'font3']
        }
      )
      diff = DifferenceBuilder.new(@original, altered).build
      matched = intersection_match?(
        diff.fonts_intersection,
        ['font1', 'font2']
      )
      expect(matched).to eq(true)
    end

    it 'gets the percent difference for installed fonts' do
      altered = create_fingerprint(
        fonts: {
          installed:   ['font1', 'font2', 'font6', 'font5'],
          uninstalled: ['font4', 'font3']
        }
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.percent_font_match).to eq(0.5)
    end

    it 'detects if the cookies have changed' do
      altered = create_fingerprint(
        cookies: 'false'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.cookies).to eq(false)
    end

    it 'detects if the language has changed' do
      altered = create_fingerprint(
        language: 'foo'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.language).to eq(false)
    end

    it 'detects if the ip has changed' do
      altered = create_fingerprint(
        ip: 'foo'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.ip).to eq(false)
    end

    it 'detects if the screen size has changed' do
      altered = create_fingerprint(
        screen: 'foo'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.screen).to eq(false)
    end

    it 'detects if the geoip calced country has changed' do
      altered = create_fingerprint(
        country: 'foo'
      )
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.country).to eq(false)
    end

  end


  context 'detects when a fingerprint has no alterations' do

    it 'gets the intersection for user agent' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      matched = intersection_match?(
        diff.user_agent_intersection,
        ['user_agent,', 'browser,', 'v1.2.3', '%%']
      )
      expect(matched).to eq(true)
    end

    it 'gets the levenshtein distance for the user agent' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.user_agent_lev).to eq(0)
    end

    it 'gets the intersection for browser version' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      matched = intersection_match?(
        diff.browser_intersection,
        ['version', '1.3ba.6', '%%']
      )
      expect(matched).to eq(true)
    end

    it 'gets the the levenshtein distance for the browser version' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.browser_lev).to eq(0)
    end

    it 'gets the intersection of fonts' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      matched = intersection_match?(
        diff.fonts_intersection,
        ['font1', 'font2', 'font3']
      )
      expect(matched).to eq(true)
    end

    it 'gets the percent difference for installed fonts' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.percent_font_match).to eq(1.0)
    end

    it 'detects if the cookies have changed' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.cookies).to eq(true)
    end

    it 'detects if the language has changed' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.language).to eq(true)
    end

    it 'detects if the ip has changed' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.ip).to eq(true)
    end

    it 'detects if the screen size has changed' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.screen).to eq(true)
    end

    it 'detects if the geoip calced country has changed' do
      altered = create_fingerprint
      diff = DifferenceBuilder.new(@original, altered).build
      expect(diff.country).to eq(true)
    end

  end

end
