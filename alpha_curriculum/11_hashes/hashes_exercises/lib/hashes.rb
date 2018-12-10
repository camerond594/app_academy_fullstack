# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  words = str.split(" ")
  length_hash = Hash.new(0)
  words.each do |word|
    length_hash[word] = word.length
  end
  length_hash
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by { |k, v| v }[-1][0]
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  newer.each do |k, v|
    older[k] = v
  end
  older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  frequency_count = Hash.new(0)

  word.split("").each do |char|
    frequency_count[char] += 1
  end
  frequency_count
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  frequency_count = Hash.new(0)

  arr.each { |el| frequency_count[el] = 1 }
  frequency_count.keys
end

# Define a method that, given an array of numbers, returns a hash with "even"
# and "odd" as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  parity_hash = Hash.new(0)
  numbers.each do |number|
    parity_hash[:even] += 1 if number.even?
    parity_hash[:odd] += 1 if number.odd?
  end
  parity_hash
end

# Define a method that, given a string, returns the most common vowel. Do
# not worry about ordering in the case of a tie. Assume all letters are
# lower case.
VOWELS = ["a", "e", "i", "o", "u"]
def most_common_vowel(string)
  num_vowels = Hash.new(0)
  string.split("").each do |char|
    num_vowels[char] += 1 if VOWELS.include?(char)
  end
  num_vowels.sort_by { |k, v| v }[-1][0]
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
def fall_and_winter_birthdays(students)
  fall_winter = Hash.new(0)
  combinations = []
  students.each do |student, month|
    fall_winter[student] = month if month >= 7
  end
  fall_winter.keys.to_a.combination(2)
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size biodiversity_index(["cat",
# "cat", "cat"]) => 1 biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  species_count = Hash.new(0)
  specimens.each do |specimen|
    species_count[specimen] += 1
  end
  number_of_species = species_count.length
  arr_count = species_count.sort_by {|k, v| v }
  largest_population_size = arr_count[species_count.length - 1][1]
  smallest_population_size = arr_count[0][1]
  number_of_species**2 * (smallest_population_size/largest_population_size)
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  normal_char_count = character_count(normal_sign)
  vandalized_char_count = character_count(vandalized_sign)
  can_tweak = true
  vandalized_char_count.each do |char, count|
    can_tweak = false if normal_char_count[char.downcase] < count
  end
  can_tweak
end

def character_count(str)
  char_count = Hash.new(0)
  str.split("").each do |char|
    next if char == " "
    char_count[char.downcase] += 1
  end
  char_count
end
