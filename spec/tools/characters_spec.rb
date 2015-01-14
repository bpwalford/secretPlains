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
    #     'o' =>  2,
    #     '4' =>  1,
    #     '*' =>  1,
    #     'i' =>  1,
    #     ' ' => -1,
    #     '3' => -1,
    #     '^' => -1,
    #   }
    # }

    @partial_two  = 'ffbb  **'
    @owt_laitrap  = '*bA%*bGG'
    # {
    #   :match  =>  0.5,
    #   :size   =>  0,
    #   :new    =>  4,
    #   :subbed => -4,
    #   :spaces => -2,
    #   :diffs  =>  {
    #     'f' => -2,
    #     ' ' => -2,
    #     'A' =>  1,
    #     '%' =>  1,
    #     'G' =>  2,
    #   }
    # }

    @partial_three  = 'a'
    @eerht_laitrap  = 'abc123!@#F'
    # {
    #   :match  =>  0.5,
    #   :size   =>  0,
    #   :new    =>  4,
    #   :subbed => -4,
    #   :spaces => -2,
    #   :diffs  =>  {
    #     'f' => -2,
    #     ' ' => -2,
    #     'A' =>  1,
    #     '%' =>  1,
    #     'G' =>  2,
    #   }
    # }

    @no_match = 'a1@uuu'
    @hctam_on = 'w5^ooo'
    # {
    #   :match  =>  0.0,
    #   :size   =>  0,
    #   :new    =>  9,
    #   :subbed => -9,
    #   :spaces =>  0,
    #   :diffs  =>  {
    #     'w'  =>  1,
    #     '5'  =>  1,
    #     '^'  =>  1,
    #     'o'  =>  1,
    #     'o'  =>  1,
    #     'o'  =>  1,
    #     'a'  => -1,
    #     '1'  => -1,
    #     '@'  => -1,
    #     'u'  => -1,
    #     'u'  => -1,
    #     'u'  => -1,
    #   }
    # }
  end


  context 'returns a hash of all calculated differences' do

    it 'gets a calculated match' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:match]).to eq(1.0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:match]).to eq(0.8)

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:match]).to eq(0.5)

      result = CharactersComparer.new(@partial_three, @eerht_laitrap).evaluate
      expect(result[:match]).to eq(0.1)

      # result = CharactersComparer.new(@no_match, @hctam_on).evaluate
      # expect(result[:match]).to eq(0.0)
    end


    it 'gets the difference in size' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:size]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:size]).to eq(2)

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:size]).to eq(0)
    end


    it 'gets the number of added characters' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:added]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:added]).to eq(3)

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:added]).to eq(4)
    end


    it 'gets the number of characters taken out' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:subbed]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:subbed]).to eq(4)

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:subbed]).to eq(0.8)
    end


    it 'gets the number of different spaces' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:spaces]).to eq(0)

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:spaces]).to eq(-1)

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:spaces]).to eq(-2)
    end


    it 'gets differences of specific characters' do
      result = CharactersComparer.new(@match, @hctam).evaluate
      expect(result[:diffs]).to eq({})

      result = CharactersComparer.new(@partial, @laitrap).evaluate
      expect(result[:diffs]).to eq({
          'o' =>  2,
          '4' =>  1,
          '*' =>  1,
          'i' =>  1,
          ' ' => -1,
          '3' => -1,
          '^' => -1,
        })

      result = CharactersComparer.new(@partial_two, @owt_laitrap).evaluate
      expect(result[:diffs]).to eq({
          'f' => -2,
          ' ' => -2,
          'A' =>  1,
          '%' =>  1,
          'G' =>  2,
        })
    end

  end

end
