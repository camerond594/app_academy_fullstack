VOWELS = ["a", "e", "i", "o"]

def translate(phrase)
  arr_phrase = phrase.split(" ")

  arr_phrase.each_with_index do |word, idx|
    pig_latin_word = consonants(word)
    arr_phrase[idx] = pig_latin_word
  end
  return arr_phrase.join(" ")
end

def consonants(word)
  new_word_start = ""
  word_arr = word.split("")
  word.each_char do |char|
    if !VOWELS.include?(char)
      new_word_start += char
      word_arr.shift
    else
      break
    end
  end
  return word_arr.join("") + new_word_start + "ay"
end
