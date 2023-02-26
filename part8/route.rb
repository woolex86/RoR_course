# frozen_string_literal: true

require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations, :name

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @name = "#{start_station.title} - #{end_station.title}"
    register_instance
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.first != station && @stations.last != station
    @stations.delete(station)
    raise 'You cannot delete the first and last stations'
  end

  def show_station
    @stations.each { |station| puts station }
  end

  def show_stations
    @stations.map(&:title)
  end

  protected

  def validate!
    raise 'Start and end stops not selected' if stations[0].nil? && stations[1].nil?
    raise 'No start or end stop selected' if stations[0].nil? || stations[1].nil?
    raise 'Start and end stops must be different' if stations[0] == stations[1]
  end
end
