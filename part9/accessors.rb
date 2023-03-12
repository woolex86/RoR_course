# frozen_string_literal: true

module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}_history") do
        instance_variable_get("#{var_name}_history") || []
      end

      define_method("#{name}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        instance_variable_set("#{var_name}_history", (send "#{name}_history").push(value))
      end
    end
  end

  def strong_attr_accessor(name, v_class)
    var_name = "@#{name}".to_sym
    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) do |value|
      raise "The value #{value} does not match the class #{v_class} of variable #{name}" if value.class != v_class

      instance_variable_set(var_name.to_s, value)
    end
  end
end

# class Test
#   extend Accessors
#   attr_accessor_with_history :my_attr, :a, :b, :c
#   strong_attr_accessor('x', String)
# end
#
# test = Test.new
# test.my_attr = 3
# test.a = 5
# test.b = 6
# test.c = 7
# puts test.instance_variables.inspect
# puts test.a_history.inspect
#
# test.x = 'asd'
# puts test.x
# test.x = 8
