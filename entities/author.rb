require_relative './common/entity'

class Author < Entity
  VALIDATION_RULES = {
    name: {
      type: String,
      nullable: false
    },
    biography: {
      type: String,
      nullable: true
    }
  }.freeze

  attr_reader :name, :biography

  def initialize(init_hash)
    validate(init_hash, VALIDATION_RULES)

    @name = init_hash[:name]
    @biography = init_hash[:biography]
    super(init_hash[:id])
  end

  def to_json(*_args)
    {
      'id': @id,
      'name': @name,
      'biography': @biography
    }
  end

  def hash
    super :name, :biography
  end
end
