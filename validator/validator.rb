module Validator
  def validate(init_hash, validation_rules)
    validation_rules.each do |prop_name, _instance_info|
      validate_one(init_hash, prop_name, validation_rules[prop_name])
    end
  end

  def validate_one(init_hash, prop_name, validation_rule)
    create_before_validation(init_hash, prop_name, validation_rule)

    nullable = validation_rule[:nullable]
    current_type = init_hash[prop_name]

    return if nullable && current_type.nil?

    check_type(init_hash, prop_name, validation_rule)
    validate_nested(init_hash, prop_name, validation_rule)
  end

  def create_before_validation(init_hash, prop_name, validation_rule)
    return unless validation_rule[:creator]

    creator = validation_rule[:creator]
    value = init_hash[prop_name]
    new_value = creator.call(value)

    init_hash[prop_name] = new_value
  end

  def check_type(init_hash, prop_name, validation_rule)
    expected_type = validation_rule[:type]
    current_type = init_hash[prop_name]

    raise "#{prop_name} is #{current_type.class}, but expected #{expected_type}" unless current_type.is_a? expected_type
  end

  def validate_nested(init_hash, prop_name, validation_rule)
    return unless validation_rule[:validate_nested]

    case validation_rule[:type]
    when Array
      validate_nested_array(init_hash, prop_name, validation_rule)
    else
      raise 'Other nested validations not implemented yet'
    end
  end

  def validate_nested_array(init_hash, prop_name, validation_rule)
    required_type = validation_rule[:validate_nested][:type]
    array = init_hash[prop_name]

    raise "Nested entities of #{array} should be #{required_type}" unless array.all? { |e| e.is_a? required_type }
  end
end
