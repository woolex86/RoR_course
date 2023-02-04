class PassengerTrain < Train
  attr_reader :number, :type, :object_name

  def initialize(number, object_name)
    super
    @type = 'passenger'
  end

end