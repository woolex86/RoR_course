require_relative 'name_object'

class PassengerWagon
  include NameObject

  attr_reader :type

  def initialize
    @type = 'passenger'
  end

end
