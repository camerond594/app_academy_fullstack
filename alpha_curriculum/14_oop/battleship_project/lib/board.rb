class Board
  attr_reader :size

  def initialize(n)
    @grid = Array.new(n, :N) { Array.new(n, :N) }
    @size = n*n
  end

  def self.print_grid(grid)
    grid.each do |row|
      joined_row = row.join(" ")
      puts joined_row
    end
  end

  def [](indices)
    @grid[indices[0]][indices[1]]
  end

  def []=(indices, value)
    @grid[indices[0]][indices[1]] = value
  end

  def num_ships
    @grid.flatten.count { |el| el == :S}
  end

  def attack(indices)
    if self[indices] == :S
      self[indices]= :H
      puts "you sunk my battleship!"
      return true
    end
    self.[]=(indices, :X)
    false
  end

  def place_random_ships
    random_quarter = @size / 4
    n = Math.sqrt(@size)

    while random_quarter > 0
      row = Random.rand(n)
      col = Random.rand(n)
      if @grid[row][col] != :S
        @grid[row][col] = :S
        random_quarter -= 1
      end
    end
  end

  def hidden_ships_grid
    n = Math.sqrt(@size)
    new_grid = Marshal.load(Marshal.dump(@grid))
    new_grid.each_with_index do |row, i|
      if row.count(:S) > 0
        row.each_with_index do |col, j|
          new_grid[i][j] = :N if new_grid[i][j] == :S
        end
      end
    end
    new_grid
  end

  def cheat
    Board.print_grid(@grid)
  end

  def print
    Board.print_grid(hidden_ships_grid)
  end

end
