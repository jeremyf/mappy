require 'active_support/inflector'

module Mappy
  class InvalidTargetBuilder < RuntimeError
  end

  # Responsible for taking a symbol, finding the appropriate class then
  # verifying that the class is "well formed."
  class TargetBuilderFactory

    def self.call(*args)
      new.call(*args)
    end

    def call(target_symbol)
      target_builder = extract_target_builder(target_symbol)
      validate!(target_builder)
      target_builder
    end

    private
    def extract_target_builder(target_symbol)
      target_symbol.to_s.classify.constantize
    end

    def validate!(target_builder)
      target_instance = target_builder.allocate

      begin
        target_instance.send(:initialize, {})
      rescue ArgumentError => e
        raise InvalidTargetBuilder.new("Expected #{target_builder} to initialize with an attributes hash.\n#{e}")
      end

    end
  end
end
