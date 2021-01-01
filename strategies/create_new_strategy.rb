require_relative './common_strategy'

class CreateNewStrategy < CommonStrategy
  def create(class_constructor, params_hash)
    instance = class_constructor.new(params_hash)
    entities.push instance

    instance
  end
end
