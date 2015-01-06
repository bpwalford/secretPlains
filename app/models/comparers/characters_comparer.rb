class CharactersComparer

  attr_reader :original, :altered

  def initialize(original, altered)
    @original = original.split('')
    @altered = altered.split('')
  end

  def evaluate
    differences = {}

    differences[:match]  = get_match

    differences[:size]   = get_size

    differences[:added]  = get_added

    differences[:subbed] = get_subbed
# binding.pry

    differences[:spaces] = get_spaces

    differences[:diffs]  = get_diffs

    differences
  end

  private

  def get_diff(list, &block)
    num = 0
    known = []
    list.each do |item|
      num += 1 if yield(item, known)
      known << item
    end
    num
  end

  def get_match
    diff = get_diff(original) {|l,k| altered.count(l) != original.count(l) && !k.include?(l)}.to_f
    (original.length - diff).to_f / original.length.to_f
  end

  def get_size
    altered.length - original.length
  end

  def get_added
    diff = get_diff(altered) {|l| !original.include?(l)}
  end

  def get_subbed
    diff = get_diff(original) {|l| !altered.include?(l)} * -1
  end

  def get_spaces
    diff = (original.count(' ') - altered.count(' ')) * -1
  end

  def get_diffs
    diff = {}
    original.each do |letter|
      if original.count(letter) != altered.count(letter)
        diff[letter] = altered.count(letter) - original.count(letter)
      end
    end
    diff
  end

end
