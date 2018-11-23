# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
  str.each_char do |char|
    str.delete!(char) if char == char.downcase
  end
end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
  if str.length % 2 == 0
    return str[str.length/2 - 1 .. str.length/2]
  else
    return str[str.length/2]
  end
end

# Return the number of vowels in a string.
VOWELS = %w(a e i o u)
def num_vowels(str)
  full_count = 0
  VOWELS.each do |vowel|
    full_count += str.count(vowel)
  end
  return full_count
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
  fact = 1
  while num > 1 do
    fact *= num
    num -= 1
  end
  return fact
end


# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = "")
  final_str = ""
  arr.each_with_index do |element, idx|
    final_str << element
    final_str << separator if idx != arr.length - 1
  end
  return final_str
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
  str.each_char.with_index do |char, idx|
    str[idx] = char.upcase if idx % 2 != 0
    str[idx] = char.downcase if idx % 2 == 0
  end
  return str
end

# Reverse all words of five more more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
  final_str = ""
  str_arr = str.split(" ")
  str_arr.each do |word|
    if word.length >= 5
      word.reverse!
    end
  end
  return str_arr.join(" ")
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
  rng = (1..n).to_a
  rng.each_with_index do |num, idx|
    rng[idx] = "fizz" if num % 3 == 0
    rng[idx] = "buzz" if num % 5 == 0
    rng[idx] = "fizzbuzz" if num % 3 == 0 && num % 5 == 0
  end
  return rng
end


# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
def my_reverse(arr)
  return arr.reverse
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
  return false if num <= 1
  rng = (2..num/2)
  rng.each do |divisor|
    return false if num % divisor == 0
  end
  return true
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  factor_arr = []
  (1..num).each do |divisor|
    factor_arr << divisor if num % divisor == 0
  end
  return factor_arr.sort
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
  factor_arr = factors(num)
  prime_fact = []
  factor_arr.each do |factor|
    prime_fact << factor if prime?(factor) == true
  end
  return prime_fact
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
  return prime_factors(num).count
end


# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
  odd_arr, even_arr = false
  odd_count, even_count = 0, 0
  odd_num, even_num = 0, 0
  arr.each do |num|
    if num % 2 == 0
      even_count += 1
      even_num = num
    else
      odd_count += 1
      odd_num = num
    end
  end
  return even_num if even_count == 1
  return odd_num
end
