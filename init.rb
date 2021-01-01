require 'json'
require_relative 'factories/factories'
require_relative './dependency_resolver/dependency_resolver'
require_relative './lib_loader/lib_loader'
require_relative './dependency_resolver/config'
require_relative './entities/library'
require 'date'

json_file = LibLoader.load

library_content = DependencyResolver.resolve(
  DEPENDENCY_RESOLVE_ORDER,
  DEPENDENCY_RESOLVE_CONFIG,
  json_file
)

lib = Library.new(library_content)

good_author = AUTHORS_FACTORY.create(name: 'Lermontov')
book = BOOKS_FACTORY.create(title: 'Good year', author: good_author)
reader = READERS_FACTORY.create(name: 'good reader', email: 'mmm@mail.ru', city: 'SUmy', street: 'Berezovaya', house: 17)
order = ORDERS_FACTORY.create(book: book, reader: reader, date: Date.new)

lib.add(order) # other entities will be included automatically

lib.top_readers(3).inspect
lib.top_books(3).inspect
lib.top_readers_of_top_books(3, 2)

LibLoader.write(lib.to_json)
