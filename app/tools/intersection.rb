class Intersection
  attr_reader :set_one, :set_two

  def initialize(set_one, set_two)
    # using sets because they have unique elements and order doesn't matter
    @set_one = set_one.to_set
    @set_two = set_two.to_set
  end

  def get_intersection
    intersection = set_one + set_two

    diff_one = set_one - set_two
    diff_two = set_two - set_one
    intersection -= diff_one
    intersection -= diff_two

    intersection
  end
end
