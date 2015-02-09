require 'rails_helper'
require_relative '../../../app/tools/calculator_components/intersection_calculater'

describe IntersectionCalculater do

  before do
    class SomeClass
      include IntersectionCalculater
    end
    @object = SomeClass.new
  end

  it 'returns an intersection for arrays' do
    original = ['a', 'b', 'd']
    altered  = ['d', 'e', 'a']
    result = @object.calculate_intersection(original, altered)
    expect(result.include?('a')).to eq(true)
    expect(result.include?('d')).to eq(true)
    expect(result.length).to eq(2)
  end

  it 'returns an intersection for matrices' do
    original = [
      ['a', 'b', 'c'],
      ['d', 'e', 'g'],
    ]
    altered  = [
      ['d', 'g', 'h'],
      ['i', 'j', 'k'],
    ]
    result = @object.calculate_intersection(original, altered)
    expect(result.include?('d')).to eq(true)
    expect(result.include?('g')).to eq(true)
    expect(result.length).to eq(2)

  end

  it 'returns an intersection for strings diliminated on spaces' do
    original = 'a b d'
    altered  = 'd e a'
    result = @object.calculate_intersection(original, altered)
    expect(result.include?('a')).to eq(true)
    expect(result.include?('d')).to eq(true)
    expect(result.length).to eq(2)
  end

end
