require_relative 'wagon'

class CargoWagon < Wagon
  
  attr_reader :type, :number, :volume, :occupy

  def initialize(number, volume)
    super(number, volume, 'cargo')
  end

  def occupyed(volume)
    @occupy += volume if @volume > volume
  end
end
