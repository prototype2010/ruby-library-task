require 'json'

class LibLoader
  DEFAULT_FILENAME = './lib.json'.freeze

  def self.load(file_name = DEFAULT_FILENAME)
    json = File.read(file_name)
    parse_json_file(json)
  rescue StandardError => e
    puts "Unable to get lib content from #{file_name}. Empty library will be instantiated"
    puts "Original error text: #{e.message}"
    {
      authors: [],
      books: [],
      orders: [],
      readers: []
    }
  end

  def self.parse_json_file(lib_content)
    JSON.parse(lib_content, { object_class: Hash, symbolize_names: true })
  end

  def self.write(lib_content, file_name = DEFAULT_FILENAME)
    File.write(file_name, lib_content)
  end
end
