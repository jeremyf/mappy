module Mappy
  # Responsible for mapping, via a legend, a source object to an instance of the
  # target.
  class Resolver
    attr_reader :target_builder, :legend
    def initialize(options = {})
      @target_builder = options.fetch(:target_builder)
      @legend = options.fetch(:legend)
    end

    def call(source)
      return source if source.is_a?(target_builder)
      attributes = extract_target_attributes_from(source)
      instantiate_target(attributes)
    end

    protected

    def extract_target_attributes_from(source)
      legend.each_with_object({}) do |(source_method, target_attribute), m|
        m[target_attribute] = extract_attribute_for(source, source_method)
        m
      end
    end

    def instantiate_target(attributes)
      target_builder.new(attributes)
    end

    def extract_attribute_for(source, method_name_or_proc)
      if method_name_or_proc.respond_to?(:call)
        method_name_or_proc.call(source)
      elsif method_name_or_proc.is_a?(::Symbol) || method_name_or_proc.is_a?(::String)
        source.send(method_name_or_proc)
      end
    end
  end
end
