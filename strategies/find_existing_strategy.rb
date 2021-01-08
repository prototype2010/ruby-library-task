require_relative '../preloader'

class FindExistingStrategy < CommonStrategy
  def create(class_constructor, params_hash)
    instance = class_constructor.new(params_hash)

    if contains? instance
      find_existing instance
    else
      entities.push instance
      instance
    end
  end

  def find_existing(instance)
    entities.find { |existing_instance| existing_instance.eql? instance }
  end

  def contains?(instance)
    !!find_existing(instance)
  end
end
