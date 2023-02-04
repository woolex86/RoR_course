class Route
  include InstanceCounter

  attr_reader :stations, :name
  
  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    @name = "#{start_station.title} - #{end_station.title}"
    register_instance
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

  def show_stations
    @stations.map {|station| station.title}
  end
end
