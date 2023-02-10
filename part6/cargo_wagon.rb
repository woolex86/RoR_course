require_relative 'name_object'

class CargoWagon
  include NameObject
  
  attr_reader :type

  def initialize
    @type = 'cargo'
  end

end
