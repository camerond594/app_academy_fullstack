class Code
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  attr_reader :pegs

  def initialize(pegs)
    if Code.valid_pegs?(pegs)
      @pegs = pegs.map!(&:upcase)
    else
      raise "pegs not valid"
    end
  end

  # Checking array for R, G, B, or Y
  def self.valid_pegs?(pegs)
    pegs.each do |peg|
      if !POSSIBLE_PEGS.keys.include?(peg.upcase)
        return false
      end
    end
    return true
  end

  # Setting array with R, G, B, or Y
  def self.random(length)
    possible_colors = ["R", "G", "B", "Y"]
    pegs = []
    (0...length).each do
      pegs << possible_colors[Random.rand(4)]
    end
    Code.new(pegs)
  end

  def self.from_string(pegs)
    Code.new(pegs.split(""))
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    total = 0
    guess.pegs.each_with_index do |peg, idx|
      total += 1 if peg == @pegs[idx]
    end
    total
  end

  def num_near_matches(guess)
    total = 0
    guess.pegs.each_with_index do |peg, idx|
      if peg != @pegs[idx]
        total += 1 if @pegs.include?(peg)
      end
    end
    total
  end

  def ==(other_code)
    return true if num_exact_matches(other_code) == other_code.pegs.length
    false
  end
end
