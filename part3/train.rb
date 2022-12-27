class Train
  attr_reader :number_wagons, :type, :current_station_index, :station, :route, :current_speed

  def initialize(number, number_wagons, type)
    @number = number
    @current_speed = 0
    @number_wagons = number_wagons
    @type = type.downcase
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

  def trailering_wagons(wagons)
    if @current_speed == 0
      @number_wagons += wagons 
    else
      puts 'Сan\'t hitch, speed is over 0'
    end
  end

  def wagon_uncoupling(wagons)
    if @current_speed == 0 && @number_wagons - wagons <= 0
      puts 'Negative number of wagons'
    elsif @current_speed == 0
      @number_wagons -= wagons
    else
      'Does not disengage, speed is greater than 0'
    end
  end

  def give_route(route)
    @route = route.stations
    @current_station_index = 0
    @station = @route.first
  end

  def move_forvard
    if @current_station_index < @route.count - 1
      @current_station_index += 1
      @station = @route[@current_station_index]
    else
      puts 'This is the last station on the route'
    end
  end

  def move_backward
    if @current_station_index > 0
      @current_station_index -= 1
      @station = @route[current_station_index]
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

end
