module DistanceCalculator

  def calculate_distance(original, altered, intersection, distance_method)
    unique_to_original = (original.flatten - intersection).sort
    unique_to_altered = (altered.flatten - intersection).sort

    original = array_to_string(unique_to_original)
    altered = array_to_string(unique_to_altered)

    distance_method.get_distance(original, altered)
  end

  private

  def array_to_string(array)
    string = ''
    array.each {|x| string += x}
    string
  end

end
