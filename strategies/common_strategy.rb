class CommonStrategy
  attr_reader :entities

  def initialize
    @entities = []
  end

  def find_by_id(id)
    entities.find { |existing_instance| existing_instance.id == id }
  end
end
