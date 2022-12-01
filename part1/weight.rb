print "Введите ваше имя: "
name = gets.chomp.capitalize

print "Введите ваш рост в сантиметрах: "
growth = gets.chomp.to_i

weight = ( growth - 110 ) * 1.15

if weight > 0
  puts "#{name}, ваш идеальный вес: #{weight} кг."
else
  puts "Ваш вес уже оптимальный"
end


