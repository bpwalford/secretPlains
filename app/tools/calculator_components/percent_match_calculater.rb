module PercentMatchCalculater

  def percent_match(original, altered)
    matched = 0

    original.each{|x| matched += 1 if altered.include?(x)}

    matched.to_f/original.length.to_f
  end

end
