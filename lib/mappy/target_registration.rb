module Mappy
  class TargetRegistration
    attr_reader :name, :source_set
    def initialize(name, config = {})
      @name = name
      @source_set = config.fetch(:source_set) { {} }
    end

    def from_source(source, &map)
      if map.nil?
        raise RuntimeError, "For #{name} (target) you attempted to register #{source.inspect} (sources) without a map"
      end
      register_source(source, map)
    end

    def call(source_instance, target)
      source_type = Mappy.type(source_instance)
      source_set.fetch(source_type).call(source_type, source_instance)
    end

    private
    def register_source(as, map)
      source_set[as] = map
    end
  end
end
