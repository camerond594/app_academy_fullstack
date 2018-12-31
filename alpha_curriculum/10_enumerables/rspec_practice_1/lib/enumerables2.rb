require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
  return 0 if arr.length == 0
  return arr.reduce(:+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_tring? helper method
def in_all_strings?(long_strings, substring)
  long_strings.all? do |long_string|
    str_arr = long_string.split(" ")
    str_arr.include?(substring)
  end
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
  str_arr = string.split(" ")
  char_arr = str_arr.join("").split("")
  occur_arr = char_arr.select { |char| char_arr.count(char) > 1 }
  return occur_arr.uniq.sort
end

# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
  str_arr = string.split(" ")
  str_arr.sort_by! { |word| word.length }
  return str_arr[(str_arr.length-2)..(str_arr.length-1)]
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
  all_letters = "abcdefghijklmnopqrstuvwxyz".split("")
  string = string.split("").uniq
  return (all_letters - string)
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
  not_repeated = []
  (first_yr..last_yr).each do |year|
    not_repeated << year if not_repeat_year?(year)
  end
  return not_repeated
end

def not_repeat_year?(year)
  yr_arr = year.to_s.split("")
  yr_arr.uniq!
  return true if yr_arr.length == 4
  return false
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
def one_week_wonders(songs)
  wonders = []
  songs.each do |song|
    wonders << song if no_repeats?(song, songs)
  end
  return wonders.uniq!
end

def no_repeats?(song_name, songs)
  prev_idx = -2
  songs.each_with_index do |curr_song, idx|
    if curr_song == song_name && idx == (prev_idx + 1)
      return false
    elsif curr_song == song_name && idx != (prev_idx + 1)
      prev_idx = idx
    end
  end
  return true
end

# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
  closest_word = ""
  closest_distance = 9999
  str_arr = string.split(" ")
  str_arr.each do |curr_word|
    curr_distance = c_distance(curr_word)
    if curr_distance < closest_distance
      closest_distance = curr_distance
      closest_word = remove_punctuation(curr_word)
    end
  end
  return closest_word
end

def c_distance(word)
  word = remove_punctuation(word)
  word_arr = word.split("")
  word_idx = word_arr.length
  while word_idx >= 0
    return (word_arr.length - word_idx) if word_arr[word_idx] == "c"
    word_idx -= 1
  end
  return 9999
end

def remove_punctuation(word)
  return word.downcase.gsub(/[^a-z0-9]/i, '')
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

def repeated_number_ranges(arr)
  repeated_ranges = []
  range_start = 0
  range_num = 9999
  count = 0

  arr.each_with_index do |number, idx|
    # First number in the array, set for a new range
    if idx == 0
      #prev_number = number
      range_start = idx
      range_num = number
    elsif idx == arr.length - 1
      if number == range_num
        count += 1
      end
      if count >= 1
        repeated_ranges << [range_start, idx]
      end
    else
      # New number; check the length of the previous range
      # Add to repeated_ranges if >= 2
      if number != range_num
        if idx - range_start >= 2
          repeated_ranges << [range_start, idx-1]
        end
        range_start = idx
        range_num = number
        count = 0
      elsif number == range_num
        count += 1
      end
    end
  end
  return repeated_ranges
end
