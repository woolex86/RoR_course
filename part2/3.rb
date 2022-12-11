numbers = [0, 1]
number = numbers[-1]

while number <= 100
  numbers.push(number)
  number += numbers[-2]
end

puts numbers
