class PassengerTrain < Train
  attr_reader :number, :type

  def initialize(number)
    super
    @type = 'passenger'
  end
end
