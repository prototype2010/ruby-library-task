require_relative 'factories/factories'
require_relative './entities/library'
require_relative './fake_data_generator/fake_data_generator'
require_relative './fake_data_generator/config'
require_relative './statistics/statistics'

def pretty_param_type(param_type)
  case param_type
  when :opt then '(Optional)'
  when :req then '(Required)'
  else
    raise "Unknown param type #{param_type}"
  end
end

def pretty_method_name(method_name)
  "`#{method_name
          .to_s
          .tr('_', ' ')
          .capitalize}`"
end

lib = Library.new

available_methods = lib
                    .methods
                    .filter { |method| method.start_with? 'top_' }

puts 'Available methods: '
available_methods.each_with_index { |method, index| puts "Method `#{method}` - option #{index + 1}" }

print 'Your choice: '

option_number = gets.chop.to_i

puts

real_option_number = option_number - 1

raise "No such option #{option_number}" unless available_methods[real_option_number]

method_symbol = available_methods[real_option_number]
chosen_method = lib.method(method_symbol)
method_params = chosen_method
                .parameters
                .map do |param_type, param_name|
  print "Please input parameter #{pretty_method_name(param_name)} #{pretty_param_type(param_type)}: "
  input_value = gets.chop.to_i

  if input_value.positive?
    input_value
  else
    Statistics::DEFAULT_VALUES[method_symbol][param_name]
  end
end

puts chosen_method.call(*method_params)
