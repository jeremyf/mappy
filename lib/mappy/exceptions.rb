module Mappy

  class InvalidTargetBuilder < RuntimeError
  end

  class MapNotFound < RuntimeError
    def initialize(map_store, keys)
      super("#{keys.inspect} not found in #{map_store.inspect}")
    end
  end

end
