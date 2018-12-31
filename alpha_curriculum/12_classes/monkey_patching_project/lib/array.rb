# Monkey-Patch Ruby's existing Array class to add your own custom methods
class Array
  def span
    return nil if self.length == 0
    return (self.max - self.min).abs
  end

  def average
    return nil if self.length == 0
    sum = self.reduce(:+).to_f
    sum / self.length
  end

  def median
    return nil if self.length == 0
    self.sort!
    if self.length % 2 == 0
      (self[self.length/2] + self[(self.length/2) - 1]).to_f / 2
    else
      self[self.length/2]
    end
  end

  def counts
    hash_count = Hash.new(0)
    self.each do |el|
      hash_count[el] += 1
    end
    hash_count
  end

  def my_count(char)
    hash_count = self.counts
    hash_count[char.downcase]
  end

  def my_index(char)
    self.each_with_index do |self_char, idx|
      return idx if self_char.downcase == char.downcase
    end
    nil
  end

  def my_uniq
    self.counts.keys
  end

  def my_transpose
    i = 0
    j = 0
    transposed_arr = Array.new(self.length){Array.new(self[0].length)}
    while i < self.length
      while j < self[0].length
        transposed_arr[i][j] = self[j][i]
        j += 1
      end
      j = 0
      i += 1
    end
    transposed_arr
  end
end
