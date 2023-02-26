# frozen_string_literal: true

class PassengerTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super
    @type = 'passenger'
  end
end
