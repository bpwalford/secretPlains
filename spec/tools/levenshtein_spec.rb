require 'rails_helper'

describe Levenshtein do

  before do
    @one   = 'kitten'
    @two   = 'sitting'
    @three = 'asdfqwer1234'
    @four  = 'abdbqbeb1b3b'
    @five  = 'asdf!@#$1234'
    @six   = 'asdf!@#$1234'
    @seven = 'asdf1234!@#$'
    @eight = 'qwer5678%^&*'
    @nine  = 'asdfasdf    asdf'
    @ten   = 'fff'
  end

  it 'returns the levenshtein distance for two partially matched strings' do
    leven = Levenshtein.new(@one, @two)
    distance = leven.distance
    expect(distance).to eq(3)

    leven = Levenshtein.new(@three, @four)
    distance = leven.distance
    expect(distance).to eq(6)

    leven = Levenshtein.new(@nine, @ten)
    distance = leven.distance
    expect(distance).to eq(13)
  end

  it 'return zero for matching stings' do
    leven = Levenshtein.new(@five, @six)
    distance = leven.distance
    expect(distance).to eq(0)
  end

  it 'return length of longer string is nothing matchs' do
    leven = Levenshtein.new(@seven, @eight)
    distance = leven.distance
    expect(distance).to eq(12)
  end

end
