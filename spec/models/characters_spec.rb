require_relative '../../app/models/comparers/characters_comparer'
require 'rails_helper'

describe 'CharactersComparer' do

  before do
    @match = 'asdf 1234 !@#$ hhhh'
    @hctam = 'asdf 1234 !@#$ hhhh'
    # {
    #   :match  => 1.0,
    #   :size   => 0,
    #   :new    => 0,
    #   :subbed => 0,
    #   :spaces => 0,
    #   :diffs  => {}
    # }

    @partial = ' word 1.2.3 $%^ drow'
    @laitrap  = 'word 1.2.4 $%* drooowi'
    # {
    #   :match  =>  0.8,
    #   :size   =>  3,
    #   :new    =>  5,
    #   :subbed => -2,
    #   :spaces => -1,
    #   :diffs  =>  {
    #     '4' =>  1,
    #     '*' =>  1,
    #     'o' =>  2,
    #     'i' =>  1,
    #     ' ' => -1,
    #     '3' => -1,
    #     '^' => -1,
    #   }
    # }

    @no_match = 'as12!@uuu'
    @hctam_on = 'we56%^ooo'
    # {
    #   :match  =>  0.0,
    #   :size   =>  0,
    #   :new    =>  9,
    #   :subbed => -9,
    #   :spaces =>  0,
    #   :diffs  =>  {
    #     'a'  =>  1,
    #     's'  =>  1,
    #     '1'  =>  1,
    #     '2'  =>  1,
    #     '!'  =>  1,
    #     '@'  =>  1,
    #     'u'  =>  1,
    #     'u'  =>  1,
    #     'u'  =>  1,
    #     'w'  => -1,
    #     'e'  => -1,
    #     'r'  => -1,
    #     't'  => -1,
    #     '5'  => -1,
    #     '6'  => -1,
    #     '%'  => -1,
    #     '^'  => -1,
    #     'o'  => -1,
    #     'o'  => -1,
    #     'o'  => -1,
    #   }
    # }
  end

  context 'returns a hash of all calculated differences' do

    it 'gets a calculated match' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:match]).to eq(1.0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:match]).to eq(0.8)
    end

    it 'gets the difference in size' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:size]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:size]).to eq(2)
    end

    it 'gets the number of added characters' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:added]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:added]).to eq(3)
    end

    it 'gets the number of characters taken out' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:subbed]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:subbed]).to eq(-2)
    end

    it 'gets the number of different spaces' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:spaces]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:spaces]).to eq(-1)
    end

    it 'gets differences of specific characters' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:diffs]).to eq({})

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:diffs]).to eq({
          '4' =>  1,
          '*' =>  1,
          'o' =>  2,
          'i' =>  1,
          ' ' => -1,
          '3' => -1,
          '^' => -1,
        })
    end

  end

end
