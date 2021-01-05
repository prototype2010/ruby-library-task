require 'securerandom'
require_relative '../../validator/validator'
require_relative '../../exceptions/exceptions'

class Entity
  include Validator

  attr_reader :id

  def initialize(id)
    @id = id.nil? ? SecureRandom.uuid : id
  end

  def hash(*props_hashes)
    props_hashes.inject(17) { |cumulative, prop| 37 * cumulative + send(prop).hash }
  end

  def eql?(other)
    hash == other.hash
  end

  def ==(other)
    hash == other.hash
  end

  def to_json(*_args)
    raise NotImplementedYetError 'Should be overridden by child class'
  end
end
