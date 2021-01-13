require_relative '../preloader'

class Order < Entity
  VALIDATION_RULES = {
    book: {
      required: true,
      type: Book
    },
    reader: {
      required: true,
      type: Reader
    },
    date: {
      required: true,
      type: Date,
      creator: lambda do |date|
        if date.is_a? String
          Date.parse(date)
        else
          Date.today
        end
      end
    }
  }.freeze

  attr_reader :book, :reader, :date

  def initialize(init_hash)
    validate(init_hash, VALIDATION_RULES)

    @book = init_hash[:book]
    @reader = init_hash[:reader]
    @date = init_hash[:date]

    super(init_hash[:id])
  end

  def to_json(*_args)
    {
      'id': @id,
      'book_id': @book.id,
      'reader_id': @reader.id,
      'date': @date
    }
  end

  def ==(other)
    if other.is_a? Order
      @reader = other.reader && (@book = other.book) && (@date == other.date)
    else
      false
    end
  end
end
