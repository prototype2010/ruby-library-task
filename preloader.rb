require 'securerandom'
require 'date'
require 'time'
require 'json'
require 'faker'

require_relative './exceptions/exceptions'

require_relative './lib_loader/lib_loader'
require_relative './validator/validator'
require_relative './statistics/statistics'
require_relative './entities/common/entity'

require_relative './strategies/common_strategy'
require_relative './strategies/create_new_strategy'
require_relative './strategies/find_existing_strategy'

require_relative './entities/author'
require_relative './entities/book'
require_relative './entities/reader'
require_relative './entities/order'

require_relative './entities/library'

require_relative './factories/common_factory'
require_relative './factories/factories'

require_relative './dependency_resolver/config'
require_relative './dependency_resolver/dependency_resolver'

require_relative './fake_data_generator/config'
require_relative './fake_data_generator/fake_data_generator'
