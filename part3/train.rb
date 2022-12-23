class Train
  attr_accessor :current_speed
  attr_reader :number_wagons, :type, :station_position, :route

  def initialize(number, number_wagons, type)
    @number = number
    @current_speed = 0
    @number_wagons = number_wagons
    @type = type.downcase
    @station_position = nil
    @route = nil
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
    @station_position = @route.first
  end

  def current_station_index
    @route.index @station_position
  end

  def move_forvard
    if current_station_index < @route.count - 1
      @station_position = @route[current_station_index + 1]
    else
      puts 'This is the last station on the route'
    end
  end

  def move_backward
    if current_station_index > 0
      @station_position = @route[current_station_index - 1]
    else
      puts 'This is the first station on the route'
    end
  end

  def show_station
    puts "Previous station: #{@route[current_station_index - 1]}, current station: #{@station_position}, next station: #{@route[current_station_index + 1]}."
  end

end

=begin
:part3 aleksejmatveev$ irb -r ./train.rb -r ./route.rb
2.5.3 :001 > train1 = Train.new(123, 20, 'pas')
 => #<Train:0x00007f85a282edd8 @current_speed=0, @number=123, @number_wagons=20, @route=nil, @station_position=nil, @type="pas"> 
2.5.3 :002 > train2 = Train.new(234, 25, 'gr')
 => #<Train:0x00007f859f9ca6b8 @current_speed=0, @number=234, @number_wagons=25, @route=nil, @station_position=nil, @type="gr"> 
2.5.3 :003 > train1.speed_up(20)
 => 20 
2.5.3 :004 > train1.speed_up(30)
 => 50 
2.5.3 :005 > train1.brake(25)
 => 25 
2.5.3 :006 > train1.speed_zero
 => 0 
2.5.3 :007 > train1.trailering_wagons(12)
 => 32 
2.5.3 :008 > train1.wagon_uncoupling(5)
 => 27 
2.5.3 :009 > route1 = Route.new('qwe', 'rty')
 => #<Route:0x00007f859f14e228 @stations=["qwe", "rty"]> 
2.5.3 :010 > route1.add_station('asdf')
 => ["qwe", "asdf", "rty"] 
2.5.3 :011 > route1.add_station('zxcvb')
 => ["qwe", "asdf", "zxcvb", "rty"] 
2.5.3 :012 > train1.give_route(route1)
 => "qwe" 
2.5.3 :013 > train1.route
 => ["qwe", "asdf", "zxcvb", "rty"] 
2.5.3 :014 > train1.current_station_index
 => 0 
2.5.3 :015 > train1.move_forvard
 => "asdf" 
2.5.3 :016 > train1.move_forvard
 => "zxcvb" 
2.5.3 :017 > train1.move_forvard
 => "rty" 
2.5.3 :018 > train1.move_backward
 => "zxcvb" 
2.5.3 :019 > train1.station_position
 => "zxcvb" 
2.5.3 :020 > train1.show_station
Previous station: asdf, current station: zxcvb, next station: rty.
 => nil 
=end
