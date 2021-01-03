require 'json'
require_relative '../dependency_resolver/dependency_resolver'
require_relative '../dependency_resolver/config'

module LibLoader
  DEFAULT_FILENAME = File.expand_path('./lib.json')

  def load(file_name = DEFAULT_FILENAME)
    json = File.read(file_name)
    parsed = parse_json_file(json)

    DependencyResolver.resolve(DEPENDENCY_RESOLVE_ORDER, DEPENDENCY_RESOLVE_CONFIG, parsed)
  rescue StandardError => e
    puts "Unable to get lib content from #{file_name}. Empty library will be instantiated"
    puts "Original error text: #{e.message}, #{e.backtrace}"
    {
      authors: [], books: [], orders: [], readers: []
    }
  end

  def parse_json_file(lib_content)
    JSON.parse(lib_content, { object_class: Hash, symbolize_names: true })
  end

  def write(file_name = DEFAULT_FILENAME)
    File.write(file_name, to_json)
  end
end
