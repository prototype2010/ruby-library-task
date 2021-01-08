require_relative '../preloader'

AUTHORS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Author)
BOOKS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Book)
READERS_FACTORY = CommonFactory.new(FindExistingStrategy.new, Reader)
ORDERS_FACTORY = CommonFactory.new(CreateNewStrategy.new, Order)
