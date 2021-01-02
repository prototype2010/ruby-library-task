require_relative '../factories/factories'

FACTORIES_CONFIG = {
  author: AUTHORS_FACTORY,
  book: BOOKS_FACTORY,
  reader: READERS_FACTORY,
  order: ORDERS_FACTORY
}.freeze
