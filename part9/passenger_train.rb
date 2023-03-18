# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :number, :type, :wagons

  @all_trains = []

  @validations = superclass.instance_variable_get(:@validations)

  def initialize(number)
    super
    @type = 'passenger'
    self.class.superclass.all_trains << self
  end
end
