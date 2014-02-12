module Mappy

  class Configuration
    attr_reader :map_store
    def initialize(config = {})
      @map_store = config.fetch(:map_store) { {} }
    end

    def legend(options = {}, &map)
      source = options.fetch(:source)
      target = options.fetch(:target)

      map_store[target] ||= {}
      map_store[target][source] = map
    end

    def map(source_instance, options = {})
      source = source_instance.to_mappy_type
      target = options.fetch(:target)
      map = map_store.fetch(target).fetch(source)

      Resolver.call(source, target, &map)
    end
  end

end
