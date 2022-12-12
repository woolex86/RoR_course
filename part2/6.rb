products = {}
loop do
  puts 'Enter the name of the product or "stop" if you want to complete the purchase'
  product = gets.chomp.downcase
  break if product == 'stop'

  puts 'Enter the price of the item'
  unit_price = gets.chomp.to_f

  puts 'Enter quantity'
  quantity = gets.chomp.to_f

  products[product] = { price: unit_price, quantity: quantity }
end

puts products

total_price = products.values.sum { |value| value[:price] * value[:quantity] }

puts "Sum of all purchases: #{total_price}."
