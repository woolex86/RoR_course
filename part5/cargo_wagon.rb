class CargoWagon
  include NameObject
  
  attr_reader :type

  def initialize
    @type = 'cargo'
  end

end
