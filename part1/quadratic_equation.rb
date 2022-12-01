print "Введите коэффициенты квадратного уравнения: "
a = gets.to_i
b = gets.to_i
c = gets.to_i

d = b**2 - 4 * a * c

if d > 0
  puts "x1 = #{ ( - b + Math.sqrt(d) ) / ( 2 * a ) } " 
  puts "x2 = #{ ( - b - Math.sqrt(d) ) / ( 2 * a ) } "
elsif d == 0
  puts "x1 = x2 = #{ ( - b ) / ( 2 * a ) }"
else d < 0
  puts 'Корней нет'
end
  
  
