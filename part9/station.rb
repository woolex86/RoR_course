# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Station
  extend Accessors
  include InstanceCounter
  include Validation

  TITLE_FORMAT = /^[a-z|\d]+$/i

  @stations = []

  class << self
    attr_accessor :stations
  end

  attr_accessor :trains, :title

  validate :title, :presence
  validate :title, :format, TITLE_FORMAT

  def initialize(title)
    @title = title
    @trains = []
    validate!
    self.class.stations << self
    register_instance
  end

  def self.all
    @stations
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

  # def valid?
  #   validate!
  #   true
  # rescue StandardError
  #   false
  # end

  # protected

  # def validate!
  #   raise 'The name of the station is not correct, please reduce the number of letters to ten' if title.length < 2
  # end
end
