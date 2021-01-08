require_relative '../preloader'

DEPENDENCY_RESOLVE_ORDER = [
  [:authors, AUTHORS_FACTORY],
  [:books, BOOKS_FACTORY],
  [:readers, READERS_FACTORY],
  [:orders, ORDERS_FACTORY]
].freeze

DEPENDENCY_RESOLVE_CONFIG = {
  author_id: {
    factory: AUTHORS_FACTORY,
    property_name: :author
  },
  book_id: {
    factory: BOOKS_FACTORY,
    property_name: :book
  },
  reader_id: {
    factory: READERS_FACTORY,
    property_name: :reader
  }
}.freeze
