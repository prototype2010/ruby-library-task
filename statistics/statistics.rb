module Statistics
  DEFAULT_VALUES = {
    top_readers: {
      top_readers_number: 1
    },
    top_books: {
      top_books_number: 1
    },
    top_readers_of_top_books: {
      top_readers_quantity: 3,
      top_books_quantity: 3
    }
  }.freeze

  def top_readers(top_readers_number = DEFAULT_VALUES[:top_readers][:top_readers_number])
    get_grouped_entities(@orders, top_readers_number, &:reader)
  end

  def top_books(top_books_number = DEFAULT_VALUES[:top_books][:top_books_number])
    get_grouped_entities(@orders, top_books_number, &:book)
  end

  def top_readers_of_top_books(
    top_readers_quantity = DEFAULT_VALUES[:top_readers_of_top_books][:top_readers_quantity],
    top_books_quantity = DEFAULT_VALUES[:top_readers_of_top_books][:top_books_quantity]
  )
    books = top_books(top_books_quantity)
    orders = @orders.filter { |order| books.include?(order.book) }

    get_grouped_entities(orders, top_readers_quantity, &:reader)
  end

  def get_grouped_entities(from, number_of_items, &group_name)
    from.group_by(&group_name)
        .transform_values(&:length)
        .to_a
        .max_by(number_of_items) { |a| a[1] }
        .map(&:first)
  end
end
