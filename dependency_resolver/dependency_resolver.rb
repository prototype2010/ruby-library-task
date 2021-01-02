class DependencyResolver
  def self.resolve(resolve_order_array, factories_hash, library_hash)
    resolve_order_array.each_with_object({}) do |resolve_config, library_content|
      entities_key, factory = resolve_config

      json_array = library_hash[entities_key]

      library_content[entities_key] = resolve_group_deps(factory, json_array, factories_hash)
                                      .uniq
    end
  end

  def self.resolve_group_deps(entity_factory, json_rows_array, factories_hash)
    json_rows_array.map do |init_params|
      external_dependencies = resolve_external_deps(init_params, factories_hash)

      entity_factory.create(init_params.merge(external_dependencies))
    end
  end

  def self.resolve_external_deps(init_params, factories_hash)
    init_params
      .to_a
      .each_with_object({}) do |entry, resolved_deps|
      sym_key, entity_id = entry

      next unless factories_hash.key?(sym_key)

      required_factory = factories_hash[sym_key][:factory]
      initialize_prop = factories_hash[sym_key][:property_name]
      resolved_deps[initialize_prop] = required_factory.find_by_id(entity_id)
    end
  end
end
