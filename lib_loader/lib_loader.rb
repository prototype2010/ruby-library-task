require_relative '../preloader'

module LibLoader
  DEFAULT_FILENAME = File.expand_path('./lib.json')

  def load(file_name = DEFAULT_FILENAME)
    if File.exist? file_name
      json = File.read(file_name)
      parsed = parse_json_file(json)
      DependencyResolver.resolve(DEPENDENCY_RESOLVE_ORDER, DEPENDENCY_RESOLVE_CONFIG, parsed)
    else
      {
        authors: [], books: [], orders: [], readers: []
      }
    end
  end

  def parse_json_file(lib_content)
    JSON.parse(lib_content, { object_class: Hash, symbolize_names: true })
  end

  def write(file_name = DEFAULT_FILENAME)
    File.write(file_name, to_json)
  end
end
