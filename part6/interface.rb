require_relative 'route'
require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'instance_counter'
require_relative 'name_object'

class Interface

  def create_station
    puts 'Enter station name: '
    station_name = gets.strip
    stations << Station.new(station_name)
    puts "You create new station #{station_name}"
  end
  
  def create_train
    puts 'Enter train number: '
    user_train_number = gets.chomp
    puts 'What type of train do you want to create?
      1 - cargo
      2 - passenger'
    user_train_type = gets.chomp.to_i
    raise "You did not enter the type of train" if user_train_type > 2 
    case user_train_type
    when 1
      @trains << CargoTrain.new(user_train_number)
      puts "You have created a train type cargo, number: #{user_train_number}."
    when 2
      @trains << PassengerTrain.new(user_train_number)
      puts "You have created a train type passenger, number: #{user_train_number}."
    end
  rescue RuntimeError
    puts 'Incorrect data was entered, please try again'
    retry
  end
  
  def create_route
    puts 'Enter the first and last station on the route'
    puts 'Enter the first station'
    show_stations
    user_first_station = @stations[gets.chomp.to_i - 1]
    puts 'Enter last station'
    show_stations
    user_last_station = @stations[gets.chomp.to_i - 1]
    routes << Route.new(user_first_station, user_last_station)
    puts "Added stations to the route #{Route.new(user_first_station, user_last_station).show_stations}"
  end
  
  def add_station_route
    puts 'Choose a route (select number): '
    show_routes
    route = choosen_route(gets.chomp.to_i - 1)
    puts 'Enter the number of the station you want to add : '
    show_stations
    name_station = choosen_station(gets.chomp.to_i - 1)
    route.add_station(name_station)
    puts "Stations on the route: #{route.show_stations}"  
  end

  def delete_station_route
    puts 'Choose a route (select number): '
    show_routes
    route = choosen_route(gets.chomp.to_i - 1)
    puts 'Enter the number of the station you want delete : '
    show_stations
    name_station = choosen_station(gets.chomp.to_i - 1)
    route.delete_station(name_station)
    puts "Stations on the route: #{route.show_stations}"  
  end

  def set_train_route
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    puts 'Enter the route of the train'
    show_routes
    route = choosen_route(gets.chomp.to_i - 1)
    train.give_route(route)
    puts "Train number #{train.number} sent along the route #{route.name}."
  end

  def add_wagons_to_train
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    puts 'Enter wagon type: "cargo" or "passenger"'
    wagon = gets.chomp
    train.add_wagon(wagon)
    puts "Train number #{train.number}, quantity of wagons #{train.wagons_amount}"
  end

  def delete_wagons_from_train
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    train.delete_wagon
    puts "Train number #{train.number}, quantity of wagons #{train.wagons_amount}"
  end

  def move_train_forvard
    puts 'Which train do you want to move forward'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    train.move_forvard
    puts "Train number #{train.number}, moved to the station #{train.station.title}."
  end

  def move_train_back
    puts 'Which train do you want to move forward'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    train.move_backward
    puts "Train number #{train.number}, moved back to the station #{train.station.title}."
  end

  def show_trains_on_the_station
    stations.each.with_index(1) do |station, number|
      puts "#{number} - #{station.title}, #{station.show_train}"
    end
  end

  private # т.к. методы используются только внутри класса

  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end


  def show_stations
    stations.each.with_index(1) do |station, number|
      puts "#{number} - #{station.title}"
    end
  end

  def show_trains
    trains.each.with_index(1) do |train, number|
      puts "#{number} - #{train.number}, #{train.class}"
    end
  end

  def show_routes
    routes.each.with_index(1) do |route, number|
      puts "#{number} - #{route.show_stations}"
    end
  end

  def choosen_station(number)
    @stations[number]
  end

  def choosen_train(number)
    @trains[number]
  end

  def choosen_route(number)
    @routes[number]
  end
end
