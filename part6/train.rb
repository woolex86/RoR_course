require_relative 'instance_counter'

class Train
  include NameObject
  include InstanceCounter

  NUMBER_FORMAT = /^\w{3}-?\w{2}$/

  attr_reader :wagons, :current_station_index, :station, :route, :current_speed, :number

  @@all_trains = []

  def self.all
    @@all_trains
  end

  def self.find(number)
    @@all_trains.find {|train| train.number == number}
  end

  def initialize(number)
    @number = number
    @current_speed = 0
    @wagons = []
    @@all_trains << self
    register_instance
    validate!
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
    @wagons.push(wagon) if @type == wagon && @current_speed.zero? 
  end

  def delete_wagon
    @wagons.pop if @current_speed == 0 && @wagons.length > 0
  end

  def give_route(route)
    @route = route.stations
    @current_station_index = 0
    @station = @route.first
    @station.add_train(self)
  end

  def move_forvard
    @current_station_index < @route.count - 1
    @station.send_train(self)
    @current_station_index += 1
    @station = @route[@current_station_index]
    @station.add_train(self)
    raise 'This is the last station on the route'
  end

  def move_backward
    @current_station_index > 0
    @station.send_train(self)
    @current_station_index -= 1
    @station = @route[current_station_index]
    @station.add_train(self)
    raise 'This is the first station on the route'
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
  rescue
    false
  end

  protected

  def validate!
    raise 'Number has invalid format' if number !~ NUMBER_FORMAT
  end

end
