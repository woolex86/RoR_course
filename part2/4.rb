letters = ('а'..'я').to_a
letters.insert(6, 'ё')

numbers = ('1'..'33').to_a

list = letters.zip(numbers)

alphabet = list.to_h
alphabet.each { |letter, number| puts "#{letter} - #{number.to_i}" }
