# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend(ClassMethods)
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, validation_type, arg = nil)
      @validations ||= []
      @validations << { name: name, type: validation_type, arg: arg }
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    end

    def validate!
      validations = self.class.instance_variable_get(:@validations)
      return unless validations

      validations.each do |validation|
        case validation[:type]
        when :presence
          validate_presence!("@#{validation[:name]}")
        when :format
          validate_format!("@#{validation[:name]}", validation[:arg])
        when :type
          validate_type!("@#{validation[:name]}", validation[:arg])
        end
      end
    end

    def validate_presence!(name)
      var = instance_variable_get(name)
      raise "Variable #{name} is nil!" if var.nil?
      raise "The variable #{name} is an empty string!" if var == ''
    end

    def validate_format!(name, regex)
      var = instance_variable_get(name)
      raise "Variable #{name} does not match regular expression #{regex}!" if var !~ regex
    end

    def validate_type!(name, type)
      var = instance_variable_get(name)
      raise "Variable #{name} does not match type #{type}!" unless var.instance_of?(type)
    end
  end
end

# class RailwayStation; end
# class BusStation; end

# class A
#   include Validation

#   validate :name, :presence
#   validate :number, :format, /^\w{3}-?\w{2}$/
#   validate :station, :type, RailwayStation

#   def initialize(name, number, station)
#     @name = name
#     @number = number
#     @station = station
#   end
# end

# test1 = A.new('qwert', '123-we', RailwayStation.new)
# p test1
# p test1.valid?

# test2 = A.new('qwert', '123', RailwayStation.new)
# p test2
# p test2.valid?

# test3 = A.new('qwert', '123-we', BusStation.new)
# p test3
# p test3.valid?

# test4 = A.new('', '123-we', RailwayStation.new)
# p test4
# p test4.valid?
