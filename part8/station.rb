# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_accessor :trains, :title

  @@stations = []

  def initialize(title)
    @title = title
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  def self.all
    @@stations
  end

  def each_train(&block)
    trains.each(&block)
  end

  def add_train(train)
    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def show_train
    @trains.map(&:number)
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  protected

  def validate!
    raise 'The name of the station is not correct, please reduce the number of letters to ten' if title.length < 2
  end
end
