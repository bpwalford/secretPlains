require 'rails_helper'
require_relative '../../../app/tools/calculator_components/percent_match_calculater'

describe PercentMatchCalculater do

  before do
    class SomeClass
      include PercentMatchCalculater
    end
    @object = SomeClass.new
  end

  it 'returns 1.0 when second parameter is fully included in the first parameter' do
    original = ['a', 'b', 'c']
    altered  = ['a', 'b', 'c']
    result = @object.percent_match(original, altered)
    expect(result).to eq(1.0)
  end

  it 'returns 0.0 when second parameter is entirely absent from first parameter' do
    original = ['a', 'b', 'c']
    altered  = ['d', 'e', 'f']
    result = @object.percent_match(original, altered)
    expect(result).to eq(0.0)
  end

  context 'returns proper percentage of second parameter within first parameter' do
    it 'return 0.75' do
      original = ['a', 'b', 'c', 'd']
      altered  = ['a', 'b', 'c']
      result = @object.percent_match(original, altered)
      expect(result).to eq(0.75)
    end

    it 'return 0.5' do
      original = ['a', 'b', 'c', 'd']
      altered  = ['a', 'b']
      result = @object.percent_match(original, altered)
      expect(result).to eq(0.5)
    end

    it 'return 0.25' do
      original = ['a', 'b', 'c', 'd']
      altered  = ['a']
      result = @object.percent_match(original, altered)
      expect(result).to eq(0.25)
    end

  end

end
