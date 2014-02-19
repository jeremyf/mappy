require "mappy/resolver"
require "mappy/target_builder_factory"
require "mappy/map_store"

module Mappy

  class Configuration
    attr_reader :map_store
    def initialize(config = {})
      @map_store = config.fetch(:map_store) { Mappy::MapStore.new }
    end

    def legend(options = {})
      map_store.write(options)
    end

    def map(source_instance, options = {})
      target = options.fetch(:target)
      target_builder_finder = options.fetch(:target_builder_finder) { Mappy::TargetBuilderFactory }
      target_builder = target_builder_finder.call(target)

      return source_instance if source_instance.is_a?(target_builder)

      source_type = extract_source_type(source_instance)
      legend = extract_legend(target, source_type)

      resolve(source_instance, target_builder, legend)
    end
    protected
    def resolve(source_instance, target_builder, legend)
      Resolver.new(
        target_builder: target_builder,
        legend: legend
      ).call(source_instance)
    end

    def extract_legend(target, source_type)
      map_store.read(source: source_type, target: target)
    end

    def extract_source_type(source_instance)
      Mappy.to_type(source_instance)
    end
  end

end
