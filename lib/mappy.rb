require "mappy/version"
require "mappy/configuration"

module Mappy
  class << self
    attr_writer :configuration
    def configuration
      @configuration ||= Configuration.new
    end
    private :configuration

  end

  module_function
  # Determines the object's Mappy type
  #
  # @param object [Object] the source object
  # @return [String] the Mappy type which should be used in configuring Mappy
  # @see Mappy.configure
  def to_type(object)
    return object.to_mappy_type if object.respond_to?(:to_mappy_type)
    object.class.to_s.underscore
  end

  # Registers a collection of maps.
  #
  # @example
  #   Mappy.configure do |config|
  #     config.register(source: 'book', target: 'orcid/work', legend: [[:name, :title]])
  #   end
  #
  # @yieldparam config [Configuration]
  # @see Mappy::Railtie
  def configure(&block)
    yield(configuration)
  end

  # Converts the source object to an instance of the options[:target].
  #
  # @example
  #   Mappy.configure do |config|
  #     config.register(source: 'book', target: 'orcid/work', legend: [:name, :title])
  #   end
  #   book = Book.new(title: 'Hello World')
  #   orcid_work = Mappy.map(book, target: 'orcid/work')
  #
  #   assert_equal orcid_work.title, book.name
  #
  # @param source [Object] :source - the instance of a class that you are mapping from
  # @param options [Hash]
  # @options options [String] :target - the class name of the target that you are mapping to.
  # @return [Object] an instance of the :target that has been instantiated by mapping the :source object
  #
  # @see Mappy.configure
  def map(source, options = {})
    configuration.map(source, options)
  end

  # Because sometimes, when you are testing things, you might want a new
  # configuration.
  # :nodoc:
  def reset!
    self.configuration = Configuration.new
  end

end
