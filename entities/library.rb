require_relative './common/entity'
require_relative 'order'
require_relative 'book'
require_relative 'author'
require_relative 'reader'
require_relative '../statistics/statistics'
require_relative '../lib_loader/lib_loader'

class Library < Entity
  include Statistics
  include LibLoader

  VALIDATION_RULES = {
    books: {
      required: true,
      type: Array,
      nested: {
        type: Book
      }
    },
    authors: {
      required: true,
      type: Array,
      nested: {
        type: Author
      }
    },
    readers: {
      required: true,
      type: Array,
      nested: {
        type: Reader
      }
    },
    orders: {
      required: true,
      type: Array,
      nested: {
        type: Order
      }
    }
  }.freeze

  attr_reader :books, :authors, :readers, :orders

  def initialize
    init_hash = load

    validate(init_hash, VALIDATION_RULES)

    @books = init_hash[:books]
    @authors = init_hash[:authors]
    @readers = init_hash[:readers]
    @orders = init_hash[:orders]

    super init_hash[:id]
  end

  def add(entity_or_array)
    entity_or_array.is_a?(Array) ? add_array(entity_or_array) : add_one(entity_or_array)
  end

  def add_array(entities_array)
    entities_array.each { |entity| add_one(entity) }
  end

  def add_one(entity)
    method_name = "add_#{entity.class.to_s.downcase}".to_sym

    return send(method_name, entity) if self.class.protected_method_defined? method_name

    raise "This type of entity cannot be added to the library #{entity.class}"
  end

  def to_json(*_args)
    JSON.pretty_generate({
                           'authors': @authors.map(&:to_json),
                           'readers': @readers.map(&:to_json),
                           'books': @books.map(&:to_json),
                           'orders': @orders.map(&:to_json)
                         })
  end

  protected

  def add_book(entity)
    @books.push(entity) unless @books.include? entity
    add_author(entity.author)
  end

  def add_author(entity)
    @authors.push(entity) unless @authors.include? entity
  end

  def add_order(entity)
    @orders.push entity

    add_book(entity.book)
    add_author(entity.book.author)
    add_reader(entity.reader)
  end

  def add_reader(entity)
    @readers.push(entity) unless @readers.include? entity
  end
end
