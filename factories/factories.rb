require_relative '../entities/author'
require_relative '../entities/book'
require_relative '../entities/reader'
require_relative '../entities/order'
require_relative './common_factory'
require_relative '../strategies/create_new_strategy'
require_relative '../strategies/find_existing_strategy'

AUTHORS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Author)
BOOKS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Book)
READERS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Reader)
ORDERS_FACTORY = CommonFactory.new(CreateNewStrategy.new, Order)
