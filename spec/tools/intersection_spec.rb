require 'rails_helper'

describe 'Intersection' do

  it 'does stuff' do
    foo = Intersection.new([1,2],[2,3])
    expect(foo.bar).to eq(2)
  end

end
