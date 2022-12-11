products = {}
loop do
  puts 'Enter the name of the product or "stop" if you want to complete the purchase'
  product = gets.chomp.downcase
  break if product == 'stop'

  puts 'Enter the price of the item'
  unit_price = gets.chomp.to_f

  puts 'Enter quantity'
  quantity = gets.chomp.to_f

  products[product] = { unit_price => quantity }
end

puts products

total_price = 0

products.each do |product, nested|
  nested.each do |unit_price, quantity|
    total_price += unit_price * quantity
    puts "#{product}: #{unit_price * quantity}"
  end
end

puts "Grand total: #{total_price}."
