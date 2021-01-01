require 'json'

class LibLoader
  def self.load(file_name = './lib.json')
    json = read_lib_file(file_name)
    parse_json_file(json)
  end

  def self.parse_json_file(lib_content)
    JSON.parse(lib_content, { object_class: Hash, symbolize_names: true })
  end

  def self.write(lib_content, file_name = './lib.json')
    File.write(file_name, lib_content)
  end

  def self.read_lib_file(file_path)
    File.read(file_path)
  rescue StandardError => e
    puts "Unable to get content from file by path #{file_path}. Make sure file exists and contains valid JSON"
    raise e
  end
end
