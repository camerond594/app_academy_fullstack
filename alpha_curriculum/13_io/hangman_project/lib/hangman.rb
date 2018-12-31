class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
    @game_over = false
  end

  def self.random_word
    DICTIONARY.sample
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    matches = []
    @secret_word.split("").each_with_index do |secret_char, idx|
      matches << idx if secret_char == char
    end
    matches
  end

  def fill_indices(char, indices)
    indices.each do |idx|
      @guess_word[idx] = char
    end
    @guess_word
  end

  def try_guess(char)
    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    end
    matching_indices = get_matching_indices(char)
    @attempted_chars << char
    if matching_indices.length == 0
      @remaining_incorrect_guesses -= 1
    else
      fill_indices(char, matching_indices)
    end
    return true
  end

  def ask_user_for_guess
    puts "Enter a char:"
    guess = gets.chomp
    try_guess(guess)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    end
    false
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    end
    false
  end

  def game_over?
    if self.win? || self.lose?
      @game_over = true
      puts @secret_word
      return true
    end
    false
  end
end
