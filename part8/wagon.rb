# frozen_string_literal: true

require_relative 'name_object'

class Wagon
  include NameObject

  def initialize(number, volume, type)
    @number = number
    @volume = volume
    @type = type
    @occupy = 0
  end

  def free_volume
    @volume - @occupy
  end
end
