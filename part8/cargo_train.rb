# frozen_string_literal: true

class CargoTrain < Train
  attr_reader :number, :type, :wagons

  @all_trains = []

  def initialize(number)
    super
    @type = 'cargo'
    self.class.superclass.all_trains << self
  end
end
