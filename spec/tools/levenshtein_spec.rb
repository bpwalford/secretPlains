require 'spec_helper'
require 'tools/levenshtein'

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
    distance = Levenshtein.new.distance(@one, @two)
    expect(distance).to eq(3)

    distance = Levenshtein.new.distance(@three, @four)
    expect(distance).to eq(6)

    distance = Levenshtein.new.distance(@nine, @ten)
    expect(distance).to eq(13)
  end

  it 'return zero for matching stings' do
    distance = Levenshtein.new.distance(@five, @six)
    expect(distance).to eq(0)
  end

  it 'return length of longer string is nothing matchs' do
    distance = Levenshtein.new.distance(@seven, @eight)
    expect(distance).to eq(12)
  end

end
