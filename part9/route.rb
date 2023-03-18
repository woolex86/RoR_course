# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Route
  extend Accessors
  include InstanceCounter
  include Validation

  attr_reader :stations, :name

  validate :stations, :presence

  def initialize(start_station, end_station)
    @stations = [start_station, end_station]
    validate!
    @name = "#{start_station.title} - #{end_station.title}"
    register_instance
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
end
