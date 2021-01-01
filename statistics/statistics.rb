module Statistics
  def top_readers(number = 1)
    target_array = get_grouped_entities(@orders, &:reader)

    get_max_allowed_slice(target_array, number)
  end

  def top_books(number = 1)
    target_array = get_grouped_entities(@orders, &:book)

    get_max_allowed_slice(target_array, number)
  end

  def top_readers_of_top_books(readers_number = 3, top_books_number = 3)
    books = top_books(top_books_number)
    orders = @orders.filter { |order| books.include?(order.book) }
    target_array = get_grouped_entities(orders, &:reader)

    get_max_allowed_slice(target_array, readers_number)
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
