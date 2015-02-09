require 'rails_helper'
require_relative '../../../app/tools/calculator_components/distance_calculator'

describe DistanceCalculator do

  before do
    class SomeClass
      include DistanceCalculator
    end
    @object = SomeClass.new

    class SomeCalculation
      def get_distance(arg1, arg2)
        arg1.length + arg2.length
      end
    end

    @distance_method = SomeCalculation.new
  end

  context 'returns a measurment based some injected calculation class' do

    it 'removes the intersection when input is an array' do
      original = ['a', 'b', 'c', 'd']
      altered  = ['d', 'e', 'f', 'a']
      intersection = original & altered
      result = @object.calculate_distance(original, altered, intersection, @distance_method)
      expect(result).to eq(4)
    end

    it 'removes the intersection when input is a matrix' do
      original = [
        ['a', 'b', 'c'],
        ['d', 'e', 'g'],
      ]
      altered  = [
        ['d', 'g', 'h'],
        ['i', 'j', 'k'],
      ]
      intersection = original.flatten & altered.flatten
      result = @object.calculate_distance(original, altered, intersection, @distance_method)
      expect(result).to eq(8)
    end

  end

end
