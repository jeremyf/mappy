module Mappy

  class Configuration
    attr_reader :map_store
    def initialize(config = {})
      @map_store = config.fetch(:map_store) { {} }
    end

    def legend(options = {})
      source = options.fetch(:source)
      target = options.fetch(:target)
      legend = options.fetch(:legend)

      map_store[target] ||= {}
      map_store[target][source] = legend
    end

    def map(source_instance, options = {})
      source = source_instance.to_mappy_type
      target = options.fetch(:target)
      legend = map_store.fetch(target).fetch(source)
    end
  end

end
