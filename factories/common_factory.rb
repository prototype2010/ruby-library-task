class CommonFactory
  attr_reader :lookup_strategy, :class_constructor, :factory_name

  def initialize(lookup_strategy, class_constructor)
    @lookup_strategy = lookup_strategy
    @class_constructor = class_constructor
    @factory_name = class_constructor.to_s
  end

  def create(params_hash)
    lookup_strategy.create(class_constructor, params_hash)
  end

  def find_by_id(id)
    lookup_strategy.find_by_id(id)
  end
end
