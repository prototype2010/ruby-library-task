require_relative 'factories/factories'
require_relative './entities/library'
require_relative './fake_data_generator/fake_data_generator'
require_relative './fake_data_generator/config'

lib = Library.new

fake_data_generator = FakeDataGenerator.new(FACTORIES_CONFIG)

author = fake_data_generator.create(:author)
author2 = fake_data_generator.create(:author, biography: 'Born in 1899')
book = fake_data_generator.create(:book)
book2 = fake_data_generator.create(:book, { author: author })
reader = fake_data_generator.create(:reader, { city: 'Sumy' })
reader2 = fake_data_generator.create(:reader)
order = fake_data_generator.create(:order)
order2 = fake_data_generator.create(:order, { book: book })

many_orders = fake_data_generator.create_many(:order, 25)

all = [author, author2, book, book2, reader, reader2, order, order2] + many_orders

lib.add(all)

lib.top_readers(3).inspect
lib.top_books(3).inspect
lib.top_readers_of_top_books(3, 2)

lib.write
