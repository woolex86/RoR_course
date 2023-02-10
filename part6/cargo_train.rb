class CargoTrain < Train
  attr_reader :number, :type

  def initialize(number)
    super
    @type = 'cargo'
  end

end
