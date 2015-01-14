require 'rails_helper'

describe Intersection do

  before do
    @set_one   = [1,2,3,4,5,6].to_set
    @set_two   = [4,5,6,7,8,9].to_set
    @set_three = ['a','b','c',1,2,'!','@'].to_set
    @set_four  = ['%','@','2',1,2,'a','v'].to_set
    @set_five  = [1,2,3].to_set
    @set_six   = [3,2,1].to_set
    @set_seven = [1,2,3].to_set
    @set_eight = [4,5,6].to_set
  end

  it 'returns the intersecting elements of two sets' do
    inter = Intersection.new(@set_one, @set_two)
    section = inter.get_intersection
    expect(section).to eq([4,5,6].to_set)

    inter = Intersection.new(@set_three, @set_four)
    section = inter.get_intersection
    expect(section).to eq(['@', 2, 1, 'a'].to_set)
  end

  it 'returns intersection where order is irrelevant' do
    inter = Intersection.new(@set_five, @set_six)
    section = inter.get_intersection
    expect(section).to eq([2,1,3].to_set)
  end

  it 'it returns nil if there is no intersection' do
    inter = Intersection.new(@set_seven, @set_eight)
    section = inter.get_intersection
    expect(section).to eq([].to_set)
  end

  it 'returns proper intersection to calculate diffs in sets' do
    inter = Intersection.new(@set_one, @set_two)
    section = inter.get_intersection
    expect(@set_one - section).to eq([1,2,3].to_set)
    expect(@set_two - section).to eq([7,8,9].to_set)
  end

end
