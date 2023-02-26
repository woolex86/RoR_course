# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'name_object'

class Train
  include NameObject
  include InstanceCounter

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/

  attr_reader :wagons, :current_station_index, :station, :route, :current_speed, :number, :type

  @@all_trains = []

  def self.all
    @@all_trains
  end

  def self.find(number)
    @@all_trains.find { |train| train.number == number }
  end

  def initialize(number)
    @number = number
    @current_speed = 0
    @type = nil
    @wagons = []
    validate!
    @@all_trains << self
    register_instance
  end

  def each_wagon(&block)
    wagons.each.with_index(&block)
  end

  def speed_up(speed)
    @current_speed += speed
  end

  def brake(speed)
    @current_speed -= speed
  end

  def speed_zero
    @current_speed = 0
  end

  def add_wagon(wagon)
    @wagons.push(wagon) if @type == wagon.type && @current_speed.zero?
  end

  def delete_wagon
    @wagons.pop if @current_speed.zero? && @wagons.length.positive?
  end

  def give_route(route)
    @route = route.stations
    @current_station_index = 0
    @station = @route.first
    @station.add_train(self)
  end

  def move_forvard
    raise 'This is the last station on the route' unless @current_station_index < @route.count - 1

    @station.send_train(self)
    @current_station_index += 1
    @station = @route[@current_station_index]
    @station.add_train(self)
  end

  def move_backward
    raise 'This is the first station on the route' unless @current_station_index.positive?

    @station.send_train(self)
    @current_station_index -= 1
    @station = @route[current_station_index]
    @station.add_train(self)
  end

  def current_station
    @station
  end

  def prev_station
    @route[@current_station_index - 1]
  end

  def next_station
    @route[@current_station_index + 1]
  end

  def wagons_amount
    @wagons.length
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end
end
