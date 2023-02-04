class Train
  include NameObject
  include InstanceCounter

  attr_reader :wagons, :current_station_index, :station, :route, :current_speed, :number

  @@all_trains = []

  def self.all
    @@all_trains
  end

  def self.find(number)
    @@all_trains.find do |train|
      if train.number == number
        number
      else
        nil
      end
    end
  end

  def initialize(number, object_name)
    @number = number
    @current_speed = 0
    @wagons = []
    @object_name = object_name
    @@all_trains << self
    register_instance
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
    if @current_station_index < @route.count - 1
      @station.send_train(self)
      @current_station_index += 1
      @station = @route[@current_station_index]
      @station.add_train(self)
    else
      puts 'This is the last station on the route'
    end
  end

  def move_backward
    if @current_station_index > 0
      @station.send_train(self)
      @current_station_index -= 1
      @station = @route[current_station_index]
      @station.add_train(self)
    else
      puts 'This is the first station on the route'
    end
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

end
