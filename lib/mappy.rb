require "mappy/version"
require "mappy/configuration"

module Mappy
  class << self
    attr_accessor :configuration
  end

  module_function

  def to_type(object)
    return object.to_mappy_type if object.respond_to?(:to_mappy_type)
    object.class.to_s.underscore
  end

  # Used for configuring available RemoteService and any additional
  # initialization requirements for those RemoteServices (i.e. credentials)
  #
  # @example
  #
  # @yieldparam config [Configuration]
  # @see Mappy::Railtie
  def configure(&block)
    @configuration_block = block

    # The Rails load sequence means that some of the configured Targets may
    # not be loaded; As such I am not calling configure! instead relying on
    # Mappy::Railtie to handle the configure! call
    finalize! unless defined?(Rails)
  end

  def map(source, options = {})
    configuration.map(source, options)
  end

  def finalize!
    if @configuration_block.respond_to?(:call)
      self.configuration ||= Configuration.new
      @configuration_block.call(configuration)
    end
  end

  def reset!
    self.configuration = Configuration.new
  end

end
