class Levenshtein
  attr_reader :count

  def initialize
    @count = 0;
  end

  def distance(str1, str2)
    return str2.length if str1.empty?
    return str1.length if str2.empty?

    @count += 1
    return distance(str1[1..-1], str2[1..-1]) if str1[0] == str2[0]
    l1 = distance(str1, str2[1..-1])
    l2 = distance(str1[1..-1], str2)
    l3 = distance(str1[1..-1], str2[1..-1])
    return 1 + [l1,l2,l3].min
  end
end
