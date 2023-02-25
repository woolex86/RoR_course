require_relative 'wagon'

class PassengerWagon < Wagon

  attr_reader :type, :number, :volume, :occupy

  def initialize(number, volume)
    super(number, volume, 'passenger')
  end

  def occupyed
    @occupy += 1
  end
end
