# EASY

# Write a method that returns the range of its argument (an array of integers).
def range(arr)
  return arr.min.abs + arr.max.abs
end

# Write a method that returns a boolean indicating whether an array is in sorted
# order. Use the equality operator (==), which returns a boolean indicating
# whether its operands are equal, e.g., 2 == 2 => true, ["cat", "dog"] ==
# ["dog", "cat"] => false
def in_order?(arr)
  sorted_arr = arr.sort
  return sorted_arr == arr
end


# MEDIUM

# Write a method that returns the number of vowels in its argument
def num_vowels(str)
  count_vowel = 0
  str = str.downcase
  count_vowel += str.count("a")
  count_vowel += str.count("e")
  count_vowel += str.count("i")
  count_vowel += str.count("o")
  count_vowel += str.count("u")
  return count_vowel
end

# Write a method that returns its argument with all its vowels removed.
def devowel(str)
  str = str.downcase
  str = str.delete("a")
  str = str.delete("e")
  str = str.delete("i")
  str = str.delete("o")
  str = str.delete("u")
  return str
end

# HARD

# Write a method that returns the returns an array of the digits of a
# non-negative integer in descending order and as strings, e.g.,
# descending_digits(4291) #=> ["9", "4", "2", "1"]
def descending_digits(int)
  return int.to_s.split("").sort.reverse
end

# Write a method that returns a boolean indicating whether a string has
# repeating letters. Capital letters count as repeats of lowercase ones, e.g.,
# repeating_letters?("Aa") => true
def repeating_letters?(str)
  return str.downcase.split("").count != str.downcase.split("").uniq.count
end

# Write a method that converts an array of ten integers into a phone number in
# the format "(123) 456-7890".
def to_phone_number(arr)
  phone_number = "("
  phone_number << arr[0..2].join("")
  phone_number << ") "
  phone_number << arr[3..5].join("")
  phone_number << "-"
  phone_number << arr[6..phone_number.length].join("")
  return phone_number
end

# Write a method that returns the range of a string of comma-separated integers,
# e.g., str_range("4,1,8") #=> 7
def str_range(str)
  arr = str.split(",")
  return arr.max.to_i.abs - arr.min.to_i.abs
end


#EXPERT

# Write a method that is functionally equivalent to the rotate(offset) method of
# arrays. offset=1 ensures that the value of offset is 1 if no argument is
# provided. HINT: use the take(num) and drop(num) methods. You won't need much
# code, but the solution is tricky!
def my_rotate(arr, offset=1)
  reduced_offset = offset % 4
  arr_take = arr.take(reduced_offset)
  arr_drop = arr.drop(reduced_offset)
  return arr_drop + arr_take
end
