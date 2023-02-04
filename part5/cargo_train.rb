class CargoTrain < Train
  attr_reader :number, :type, :object_name

  def initialize(number, object_name)
    super
    @type = 'cargo'
  end

end