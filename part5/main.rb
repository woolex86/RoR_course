require_relative 'route'
require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'interface'

interface = Interface.new

loop do
  puts '
    What action do you want to take? Please select the correct number
    1 - create a station
    2 - create a train
    3 - create a route
    4 - add station on the route
    5 - delete station on the route
    6 - assign a train route
    7 - add wagons to the train
    8 - unhook the wagons from the train
    9 - move the train forward along the route
    10 - move the train back along the route
    11 - View a list of stations and a list of trains in a station
    0 - exit'

    choice = gets.chomp.to_i
    
    case choice
    when 1
      interface.create_station
    when 2
      interface.create_train
    when 3
      interface.create_route
    when 4
      interface.add_station_route
    when 5
      interface.delete_station_route
    when 6
      interface.set_train_route
    when 7
      interface.add_wagons_to_train
    when 8
      interface.delete_wagons_from_train
    when 9
      interface.move_train_forvard
    when 10
      interface.move_train_back
    when 11  
      interface.show_trains_on_the_station
    when 0
      break
    end
end
