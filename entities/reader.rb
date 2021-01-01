require_relative './common/entity'

class Reader < Entity
  VALIDATION_RULES = {
    name: {
      type: String,
      nullable: false
    },
    email: {
      type: String,
      nullable: false
    },
    city: {
      type: String,
      nullable: false
    },
    street: {
      type: String,
      nullable: false
    },
    house: {
      type: Integer,
      nullable: true
    }
  }.freeze

  attr_reader :name, :email, :city, :street, :house

  def initialize(init_hash)
    validate(init_hash, VALIDATION_RULES)

    @name = init_hash[:name]
    @email = init_hash[:email]
    @city = init_hash[:city]
    @street = init_hash[:street]
    @house = init_hash[:house]
    super(init_hash[:id])
  end

  def to_json(*_args)
    {
      'id': @id,
      'name': @name,
      'email': @email,
      'city': @city,
      'street': @street,
      'house': @house
    }
  end

  def hash
    super :email
  end
end
