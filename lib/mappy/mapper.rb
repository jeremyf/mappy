module Mappy

  class InvalidServiceMapping < RuntimeError
    def initialize(errors)
      super(errors.join(". ") << '.')
    end
  end

  # The Mapper is responsible for transforming a target, via a Map, into an
  # acceptable format for a Minter
  class Mapper

    attr_reader :map
    def initialize(service_class, map_builder = Map, &mapping_block)
      @map = map_builder.new(service_class, &mapping_block)
    end

    def call(target, wrapper_builder = Wrapper)
      wrapper_builder.new(map, target)
    end

    # The Wrapper provides the getting and setting behavior for a target based on a Map
    class Wrapper
      attr_reader :map, :target
      def initialize(map, target)
        @map, @target = map, target
      end

      def extract_payload
        map._getters.each_with_object({}) do |(key, getter), mem|
          mem[key] = extract_attribute_for(target, getter, key)
          mem
        end
      end

      private

      def extract_attribute_for(target, getter, field_name)
        if getter.respond_to?(:call)
          getter.call(target)
        elsif getter.is_a?(::Symbol) || getter.is_a?(::String)
          target.send(getter)
        elsif getter.is_a?(::Hash)
          datastream = getter.fetch(:at)
          field = getter.fetch(:in, field_name)
          target.datastreams["#{datastream}"].send("#{field}")
        end
      end
    end

    # The Map is responsible for defining which attributes on the target map
    # to the attributes expected in the RemoteService as well as defining
    # how the RemoteService can update the target
    class Map < BasicObject
      attr_reader :service_class, :_getters
      def initialize(service_class, &config)
        @service_class = service_class
        @_getters = {}
        @errors = []
        config.call(self)
        ::Kernel.raise ::Mappy::InvalidServiceMapping.new(@errors) if @errors.any?
      end

      def inspect
        "#<Mappy::Mapper::Map for #{service_class} (#{__FILE__})>"
      end

      def method_missing(method_name, *args, &block)
        @_getters[method_name] = args.first || block
      end
    end

  end

end
