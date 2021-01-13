require_relative '../../preloader'

class Entity
  include Validator

  alias eql? ==

  attr_reader :id

  def initialize(id)
    @id = id.nil? ? SecureRandom.uuid : id
  end

  def ==(other)
    if other.is_a? Entity
      @id == other.id
    else
      false
    end
  end

  def to_json(*_args)
    raise NotImplementedYetError 'Should be overridden by child class'
  end
end
