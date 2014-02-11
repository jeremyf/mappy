module Mappy
  class Configuration

    attr_reader :registration_builder, :target_set
    def initialize(config = {})
      @target_set = config.fetch(:target_set) { {} }
      @registration_builder = config.fetch(:registration_builder) { TargetRegistration.method(:new) }
    end

    def to_target(name)
      registration = registration_builder.call(name)
      yield(registration) if block_given?
      target_set[name] = registration
      self
    end

    def map(source, options = {})
      to = options.fetch(:to)
      mapper = options.fetch(:mapper) { target_set.fetch(to) }
      mapper.call(source, to)
    end
  end
end
