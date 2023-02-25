require_relative 'route'
require_relative 'station'
require_relative 'wagon'
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
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
  end
  
  def create_train
    puts 'Enter train number: '
    user_train_number = gets.chomp
    puts 'What type of train do you want to create?
      1 - cargo
      2 - passenger'
    user_train_type = gets.chomp.to_i
    raise "You did not enter the type of train" if user_train_type > 2 || user_train_type == /^[a-z]$/i
    case user_train_type
    when 1
      @trains << CargoTrain.new(user_train_number)
      puts "You have created a train type cargo, number: #{user_train_number}."
    when 2
      @trains << PassengerTrain.new(user_train_number)
      puts "You have created a train type passenger, number: #{user_train_number}."
    end
  rescue RuntimeError => e
    puts "#{e.message}"
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
  rescue RuntimeError => e
    puts "#{e.message}"
    retry
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
    puts 'Enter wagon number'
    number = gets.chomp
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    if train.instance_of? PassengerTrain
      puts 'Enter the total number of seats in the wagon'
      quantity = gets.chomp.to_i
      train.add_wagon(PassengerWagon.new(number, quantity))
      puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}, wagon number: #{number}, passenger seats: #{quantity}"
    elsif train.instance_of? CargoTrain
      puts 'Enter wagon volume'
      quantity = gets.chomp.to_i
      train.add_wagon(CargoWagon.new(number, quantity))
      puts "You added wagon to the train - #{train.number}, amount of wagons: #{train.wagons_amount}, wagon number: #{number}, wagon volume: #{quantity}"
    end
  end

  def delete_wagons_from_train
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    train.delete_wagon
    puts "Train number #{train.number}, quantity of wagons #{train.wagons_amount}"
  end

  def occupy_wagon
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    puts 'Enter the wagon you want to occupy:'
    train.each_wagon { |wagon, num| puts "#{num + 1} - #{wagon.number}" }
    user_choice = gets.chomp.to_i
    wagon = train.wagons[user_choice - 1]
    if wagon.instance_of? PassengerWagon
      wagon.occupyed
      puts "There are empty seats in the wagon: #{wagon.free_volume}"
    elsif wagon.instance_of? CargoWagon
      puts 'Enter the volume of the wagon you want to borrow'
      volume = gets.chomp.to_i
      wagon.occupyed(volume)
      puts "The remaining volume of the wagon: #{wagon.free_volume}"
    end
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
    puts 'Choose the station'
    show_stations
    station = choosen_station(gets.chomp.to_i - 1)
    puts 'list of trains on the station:'
    station.each_train do |train|
      puts "Number #{train.number}, type: #{train.class},amount of wagons: #{train.wagons_amount}"
      train.each_wagon do |wagon|
        puts 'list of wagons on this train'
        if wagon.instance_of? PassengerWagon
          puts "Wagon №: #{wagon.number},occupied seats #{wagon.occupy}, free seats: #{wagon.free_volume},wagon type: #{wagon.class}"
        end
        if wagon.instance_of? CargoWagon
          puts "Wagon №: #{wagon.number},occupied space #{wagon.occupy}, free space: #{wagon.free_volume}, wagon type: #{wagon.class}"
        end
      end
    end 
  end

  def show_wagons_on_the_train
    puts 'Choose the train'
    show_trains
    train = choosen_train(gets.chomp.to_i - 1)
    train.each_wagon do |wagon|
      puts 'List of wagons on this train'
      if wagon.instance_of? PassengerWagon
        puts "Wagon №: #{wagon.number},occupied seats #{wagon.occupy}, free seats: #{wagon.free_volume},wagon type: #{wagon.class}"
      end
      if wagon.instance_of? CargoWagon
        puts "Wagon №: #{wagon.number},occupied space #{wagon.occupy}, free space: #{wagon.free_volume}, wagon type: #{wagon.class}"
      end
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
