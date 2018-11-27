def reverser(&word)
  word_arr = word.call.split(" ")
  final_phrase = []
  word_arr.each do |curr_word|
    final_phrase << curr_word.reverse
  end
  final_phrase.join(" ")
end

def adder(additive = 1, &number)
  number.call(1) + additive
end

def repeater(times_to_repeat = 1, &repeated)
  times_to_repeat.times {repeated.call(1)}
end
