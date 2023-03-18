# frozen_string_literal: true

require_relative 'route'
require_relative 'station'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'
require_relative 'wagon'
require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'interface'
require_relative 'instance_counter'
require_relative 'name_object'
require_relative 'validation'

@interface = Interface.new

MENU = {
  1 => { title: 'create station', action: :create_station },
  2 => { title: 'create a train', action: :create_train },
  3 => { title: 'create a route', action: :create_route },
  4 => { title: 'add station on the route', action: :add_station_route },
  5 => { title: 'delete station on the route', action: :delete_station_route },
  6 => { title: 'assign a train route', action: :set_train_route },
  7 => { title: 'add wagons to the train', action: :add_wagons_to_train },
  8 => { title: 'unhook the wagons from the train', action: :delete_wagons_from_train },
  9 => { title: 'take a seat or volume in a carriage', action: :occupy_wagon },
  10 => { title: 'move the train forward along the route', action: :move_train_forvard },
  11 => { title: 'move the train back along the route', action: :move_train_back },
  12 => { title: 'View a list of stations and a list of trains in a station', action: :show_trains_on_the_station },
  13 => { title: 'Show the list of train wagons', action: :show_wagons_on_the_train },
  0 => { title: 'exit' }
}.freeze

def show_menu
  puts 'What action do you want to take? Please select the correct number'
  MENU.each do |key, value|
    puts "#{key} - #{value[:title]}"
  end
end

def gets_action
  gets.chomp.to_i
end

def call_action(choice)
  @interface.send(MENU[choice][:action])
end

loop do
  show_menu
  choice = gets_action
  break if choice.zero?

  call_action(choice)
end
