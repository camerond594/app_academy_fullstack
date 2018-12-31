class Player
  def get_move
    puts "enter a position with coordinates separated with a space like `4 7`"
    response = gets.chomp.split(" ")
    response.map { |el| el.to_i }
  end
end
