class CargoTrain < Train
  attr_reader :number, :type, :wagons

  def initialize(number)
    super
    @type = 'cargo'
  end
end
