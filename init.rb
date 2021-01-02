require 'json'
require_relative 'factories/factories'
require_relative './dependency_resolver/dependency_resolver'
require_relative './lib_loader/lib_loader'
require_relative './dependency_resolver/config'
require_relative './entities/library'
require_relative './fake_data_generator/fake_data_generator'
require_relative './fake_data_generator/config'

json_file = LibLoader.load

library_content = DependencyResolver.resolve(
  DEPENDENCY_RESOLVE_ORDER,
  DEPENDENCY_RESOLVE_CONFIG,
  json_file
)

lib = Library.new(library_content)

fake_data_generator = FakeDataGenerator.new(FAKE_FACTORIES_CONFIG)

author = fake_data_generator.create(:author) # partially fake
author2 = fake_data_generator.create(:author, biography: 'Born in 1899') # completely fake
book = fake_data_generator.create(:book) # completely fake
book2 = fake_data_generator.create(:book, { author: author }) # partially fake
reader = fake_data_generator.create(:reader, { city: 'Sumy' }) # partially fake
reader2 = fake_data_generator.create(:reader) # completely fake
order = fake_data_generator.create(:order) # completely fake
order2 = fake_data_generator.create(:order, { book: book }) # partially fake

many_orders = fake_data_generator.create_many(:order)

all = [author, author2, book, book2, reader, reader2, order, order2] + many_orders

lib.add(all) # other entities will be included automatically

lib.top_readers(3).inspect
lib.top_books(3).inspect
lib.top_readers_of_top_books(3, 2)

LibLoader.write(lib.to_json)
