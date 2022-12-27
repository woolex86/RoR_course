class Route
  attr_reader :stations
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    if @stations.first != station && @stations.last != station
       @stations.delete(station)
    else
      puts 'You cannot delete the first and last stations'
    end
  end

  def show_station
    @stations.each { |station| puts station }
  end

end

=begin
:part3 aleksejmatveev$ irb -r ./route.rb
2.5.3 :001 > route = Route.new('qwe', 'rty')
 => #<Route:0x00007fb584b7c960 @stations=["qwe", "rty"]> 
2.5.3 :002 > route.add_station('asdf')
 => ["qwe", "asdf", "rty"] 
2.5.3 :003 > route.add_station('hjkl')
 => ["qwe", "asdf", "hjkl", "rty"] 
2.5.3 :004 > route.delete_station('qwe')
You cannot delete the first and last stations
 => nil 
2.5.3 :005 > route.delete_station('asdf')
 => "asdf" 
2.5.3 :006 > route.show_station
qwe
hjkl
rty
 => ["qwe", "hjkl", "rty"] 
=end
