require 'rails_helper'
require_relative '../../../app/tools/calculator_components/distance_calculater'

describe DistanceCalculater do

  before do
    class SomeClass
      include DistanceCalculater
    end
    @object = SomeClass.new
  end

  it 'returns a distance based on two arguments minus the intersection' do
  end

end
