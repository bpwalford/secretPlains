module IntersectionCalculator

  def calculate_intersection(original, altered)
    data_type = original.class
    intersection = nil

    if data_type == Array
      intersection = original.flatten & altered.flatten
    elsif data_type == String
      intersection = original.split(' ') & altered.split(' ')
    end

    intersection
  end

end
