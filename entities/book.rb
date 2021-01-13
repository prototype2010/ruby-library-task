require_relative '../preloader'

class Book < Entity
  VALIDATION_RULES = {
    title: {
      required: true,
      type: String
    },
    author: {
      required: true,
      type: Author
    }
  }.freeze

  attr_reader :title, :author

  def initialize(init_hash)
    validate(init_hash, VALIDATION_RULES)

    @title = init_hash[:title]
    @author = init_hash[:author]
    super(init_hash[:id])
  end

  def to_json(*_args)
    {
      'id': @id,
      'author_id': @author.id,
      'title': @title
    }
  end

  def ==(other)
    if other.is_a? Book
      (@title == other.title) && (@author == other.author)
    else
      false
    end
  end
end
