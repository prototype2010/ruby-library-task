class DependencyResolver
  def self.resolve(resolve_order_config, factories_config, json_file_content)
    resolve_order_config.each_with_object({}) do |resolve_config, library_init_params|
      entities_key, factory = resolve_config

      json_array = json_file_content[entities_key]

      library_init_params[entities_key] = resolve_array_deps(factory, json_array, factories_config)
                                          .uniq
    end
  end

  def self.resolve_array_deps(entity_factory, json_rows_array, factories_config)
    json_rows_array.map do |init_params|
      external_dependencies = resolve_one_deps(init_params, factories_config)

      entity_factory.create(init_params.merge(external_dependencies))
    end
  end

  def self.resolve_one_deps(init_params, factories_config)
    init_params
      .to_a
      .each_with_object({}) do |entry, resolved_deps|
      sym_key, entity_id = entry

      next unless factories_config.key?(sym_key)

      required_factory = factories_config[sym_key][:factory]
      initialize_prop = factories_config[sym_key][:property_name]
      resolved_deps[initialize_prop] = required_factory.find_by_id(entity_id)
    end
  end
end
