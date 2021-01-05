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
    target_array = get_grouped_entities(@orders, &:reader)

    get_max_allowed_slice(target_array, top_readers_number)
  end

  def top_books(top_books_number = DEFAULT_VALUES[:top_books][:top_books_number])
    target_array = get_grouped_entities(@orders, &:book)

    get_max_allowed_slice(target_array, top_books_number)
  end

  def top_readers_of_top_books(
    top_readers_quantity = DEFAULT_VALUES[:top_readers_of_top_books][:top_readers_quantity],
    top_books_quantity = DEFAULT_VALUES[:top_readers_of_top_books][:top_books_quantity]
  )
    books = top_books(top_books_quantity)
    orders = @orders.filter { |order| books.include?(order.book) }
    target_array = get_grouped_entities(orders, &:reader)

    get_max_allowed_slice(target_array, top_readers_quantity)
  end

  def get_max_allowed_slice(target_array, requested_number)
    max_slice = target_array.length > requested_number ? requested_number : target_array.length

    target_array
      .slice(-max_slice, max_slice)
      .reverse
  end

  def get_grouped_entities(from, &group_name)
    from.group_by(&group_name)
        .transform_values(&:length)
        .to_a
        .sort_by { |a| a[1] }
        .map(&:first)
  end
end
