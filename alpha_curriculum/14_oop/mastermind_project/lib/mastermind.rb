require_relative "code"

class Mastermind
  def initialize(length)
    @secret_code = Code.random(length)
  end

  def print_matches(code)
    puts @secret_code.num_exact_matches(code)
    puts @secret_code.num_near_matches(code)
  end

  def ask_user_for_guess
    puts "Enter a code"
    response = gets.chomp
    created_code = Code.from_string(response)
    print_matches(created_code)
    created_code == @secret_code
  end
end
