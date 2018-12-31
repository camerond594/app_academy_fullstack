require_relative "board"
require_relative "player"

class Battleship
  attr_reader :board, :player

  def initialize(n)
    @player = Player.new
    @board = Board.new(n)
    @remaining_misses = (n*n) / 2
  end

  def start_game
    @board.place_random_ships
    puts @board.num_ships
    @board.print
  end

  def lose?
    if @remaining_misses <= 0
      puts "you lose"
      return true
    else
      false
    end
  end

  def win?
    if @board.num_ships == 0
      puts "you win"
      return true
    else
      false
    end
  end

  def game_over?
    if self.win? || self.lose?
      return true
    else
      false
    end
  end

  def turn
    successful_attack = @board.attack(@player.get_move)
    @remaining_misses -= 1 if !successful_attack
    @board.print
    puts @remaining_misses
  end
end
