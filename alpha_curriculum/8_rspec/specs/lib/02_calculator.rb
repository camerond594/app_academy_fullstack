def add(num1, num2)
  return num1 + num2
end

def subtract(num1, num2)
  return num1 - num2
end

def sum(nums)
  total = 0
  nums.each do |num|
    total += num
  end
  return total
end

def multiply(*nums)
  total = 1
  nums.each do |num|
    total *= num
  end
  return total
end

def power(num1, num2)
  return num1**num2
end

def factorial(num)
  fact = 1
  while num >= 2 do
    fact *= num
    num -= 1
  end
  return fact
end
