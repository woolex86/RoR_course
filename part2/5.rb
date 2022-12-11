puts 'Enter birthday: '
user_day = gets.chomp.to_i
puts 'Enter month of birth: '
user_month = gets.chomp.to_i
puts 'Enter year of birth: '
user_year = gets.chomp.to_i

day_in_months = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30,
                  12 => 31 }

day_in_months[2] = 29 if user_year % 100 == 0 && user_year % 400 == 0 || user_year % 4 == 0 

number_of_day = 0
day_in_months.each do |month, day|
  break if month == user_month

  number_of_day += day
end

number_of_day += user_day
puts number_of_day
