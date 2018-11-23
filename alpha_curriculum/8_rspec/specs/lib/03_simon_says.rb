def echo(phrase)
  return phrase
end

def shout(phrase)
  return phrase.upcase
end

def repeat(phrase, num = 2)
  new_phrase = phrase
  (1...num).each do
    new_phrase += " "
    new_phrase += phrase
  end
  return new_phrase
end

def start_of_word(word, num_letters)
  return word[0...num_letters]
end

def first_word(phrase)
  arr_phrase = phrase.split(" ")
  return arr_phrase[0]
end

def titleize(phrase)
  arr_phrase = phrase.split(" ")
  arr_phrase.each_with_index do |word, idx|
    arr_phrase[idx].capitalize! if idx == 0 || idx == arr_phrase.length - 1
    arr_phrase[idx].capitalize! if word.length >= 5
  end
  return arr_phrase.join(" ")
end
