# EASY

# Define a method that returns an array of only the even numbers in its argument
# (an array of integers).
def get_evens(arr)
  arr.reduce([]) do |even_arr, num|
    if num.even?
      even_arr << num
    else
      even_arr
    end
  end
end

# Define a method that returns a new array of all the elements in its argument
# doubled. This method should *not* modify the original array.
def calculate_doubles(arr)
  return arr.map { |int| int * 2 }
end

# Define a method that returns its argument with all the argument's elements
# doubled. This method should modify the original array.
def calculate_doubles!(arr)
  return arr.map! { |int| int * 2 }
end

# Define a method that returns the sum of each element in its argument
# multiplied by its index. array_sum_with_index([2, 9, 7]) => 23 because (2 * 0) +
# (9 * 1) + (7 * 2) = 0 + 9 + 14 = 23
def array_sum_with_index(arr)
  idx = 0
  arr.reduce(0) do |sum, curr_num|
    sum += curr_num * idx
    idx += 1
    sum
  end
end

# MEDIUM

# Given an array of bids and an actual retail price, return the bid closest to
# the actual retail price without going over that price. Assume there is always
# at least one bid below the retail price.
def price_is_right(bids, actual_retail_price)
  bids.reduce(0) do |closest_bid, curr_bid|
    if curr_bid <= actual_retail_price && curr_bid > closest_bid
      closest_bid = curr_bid
    else
      closest_bid
    end
  end
end

# Given an array of numbers, return an array of those numbers that have at least
# n factors (including 1 and the number itself as factors).
# at_least_n_factors([1, 3, 10, 16], 5) => [16] because 16 has five factors (1,
# 2, 4, 8, 16) and the others have fewer than five factors. Consider writing a
# helper method num_factors
def at_least_n_factors(numbers, n)
  numbers.reduce([]) do |num_factors, curr_num|
    if num_factors(curr_num) >= n
      num_factors << curr_num
    else
      num_factors
    end
  end
end

def num_factors(number)
  return 1 if number < 2
  (2..number).reduce([]) do |factors, curr_num|
    if curr_num == number
      return factors.count + 2
    elsif number % curr_num == 0
      factors << curr_num
    else
      factors
    end
  end
end

# HARD

# Define a method that accepts an array of words and returns an array of those
# words whose vowels appear in order. You may wish to write a helper method:
# ordered_vowel_word?
def ordered_vowel_words(words)
  words.reduce([]) do |ord_vowels, curr_word|
    if ordered_vowel_word?(curr_word) == true
      ord_vowels << curr_word
    else
      ord_vowels
    end
  end
end

VOWELS = ["a", "e", "i", "o", "u"]
def ordered_vowel_word?(word)
  prev_ind = -1
  word_arr = word.split("")
  word_arr.reduce([]) do |vowels, curr_char|
    # We only care if the curr_char is a vowel, not a consonant
    if VOWELS.include?(curr_char)
      curr_ind = VOWELS.index(curr_char)
      # This is our first vowel
      if prev_ind < 0
        prev_ind = curr_ind
        vowels << curr_char
      else
        # If our current vowel is "greater than" the previous vowel
        if curr_ind > prev_ind
          prev_ind = curr_ind
          vowels << curr_char
        # If our current vowel is "less than" the previous, then it is not ordered
        else
          return false
        end
      end
    else
      vowels
    end
  end
  return true
end

# Given an array of numbers, return an array of all the products remaining when
# each element is removed from the array. You may wish to write a helper method:
# array_product.

# products_except_me([2, 3, 4]) => [12, 8, 6], where: 12 because you take out 2,
# leaving 3 * 4. 8, because you take out 3, leaving 2 * 4. 6, because you take out
# 4, leaving 2 * 3

# products_except_me([1, 2, 3, 5]) => [30, 15, 10, 6], where: 30 because you
# take out 1, leaving 2 * 3 * 5 15, because you take out 2, leaving 1 * 3 * 5
# 10, because you take out 3, leaving 1 * 2 * 5 6, because you take out 5,
# leaving 1 * 2 * 3
def products_except_me(numbers)
  product_idx = 0
  new_numbers = []
  while product_idx < 4
    new_numbers << array_product(numbers, product_idx)
    product_idx += 1
  end
  return new_numbers
end

def array_product(array, product_idx)
  idx = 0
  product = 1
  while idx < 4
    if idx != product_idx
      product *= array[idx]
    end
    idx += 1
  end
  return product
end
