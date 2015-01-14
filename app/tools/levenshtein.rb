class Levenshtein
  attr_reader :string_one, :string_two

  def initialize(string_one, string_two)
    @string_one = string_one
    @string_two = string_two
  end

  def distance
    matrix = [(0..string_one.length).to_a]
    (1..string_two.length).each do |j|
      matrix << [j] + [0] * (string_one.length)
    end

    (1..string_two.length).each do |i|
      (1..string_one.length).each do |j|
        if string_one[j-1] == string_two[i-1]
          matrix[i][j] = matrix[i-1][j-1]
        else
          matrix[i][j] = [
            matrix[i-1][j],
            matrix[i][j-1],
            matrix[i-1][j-1],
          ].min + 1
        end
      end
    end

    matrix.last.last
  end

end
