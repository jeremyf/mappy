module Mappy
  class Configuration
    attr_reader :registration_builder
    def initialize(config = {})
      @target_set = config.fetch(:target_set) { {} }
      @registration_builder = config.fetch(:registration_builder) { Registration.method(:new) }
    end

    def to_target(name)
      registration = registration_builder.call(name)
      yield(registration) if block_given?
      @target_set[name] = registration
      self
    end

    def map(source, options)
      to = options.fetch(:to)
      @target_set.fetch(to).call(source)
    end
  end
end
