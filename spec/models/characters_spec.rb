require_relative '../../app/models/comparers/characters'
require 'rails_helper'

describe 'Characters' do

  before do
    user = create_user
    @before = ' word 1.2.3 $%^ drow'
    @after  = 'word 1.2.4 $%* drooowi'
  end

  it 'returns a hash of all calculated differences' do
    result = Characters.new(@before, @after).evaluate
    expect(result).to eq({
        :match  => 0.8,
        :size   => '+3',
        :chars  => {'+' => 5, '-' => 2 },
        :spaces => '0',
        '4' => '+1',
        '3' => '-1',
        '^' => '-1',
        '*' => '+1',
        'o' => '+2',
        'i' => '+1',
        ' ' => '-1',
      })
  end

end
