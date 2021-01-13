require_relative '../preloader'

class FakeDataGenerator
  CREATE_MANY_DEFAULT = 50
  BIOGRAPHY_DEFAULT_LENGTH = 10

  attr_reader :available_factories

  def initialize(factories)
    @factories = factories
  end

  def create_many(entity_symbol, number = CREATE_MANY_DEFAULT)
    (0..number)
      .to_a
      .map { create(entity_symbol) }
  end

  def create(entity_symbol, **override_params)
    method_name = "fake_#{entity_symbol}"
    raise InitializeError "No available factory for entity #{entity_symbol}" unless respond_to? method_name

    send(method_name, override_params)
  end

  def fake_author(**override_params)
    fake_params = {
      name: Faker::Name.name,
      biography: Faker::Alphanumeric.alphanumeric(number: BIOGRAPHY_DEFAULT_LENGTH)
    }

    @factories[:author].create(fake_params.merge(override_params))
  end

  def fake_book(**override_params)
    fake_params = {
      author: fake_author,
      title: Faker::Name.name
    }

    @factories[:book].create(fake_params.merge(override_params))
  end

  def fake_reader(**override_params)
    fake_params = {
      name: Faker::Name.name,
      email: Faker::Internet.email,
      city: Faker::Address.state,
      street: Faker::Address.street_address,
      house: Faker::Number.number
    }

    @factories[:reader].create(fake_params.merge(override_params))
  end

  def fake_order(**override_params)
    fake_params = {
      reader: fake_reader,
      book: fake_book,
      date: Date.today
    }

    @factories[:order].create(fake_params.merge(override_params))
  end
end
