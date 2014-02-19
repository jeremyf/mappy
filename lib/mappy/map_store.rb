require File.expand_path('../exceptions', __FILE__)

module Mappy

  class MapStore
    def initialize
      @storage = {}
    end

    def write(options = {})
      source = options.fetch(:source)
      target = options.fetch(:target)
      legend = options.fetch(:legend)
      @storage[target] ||= {}
      @storage[target][source] = legend
    end

    def read(options = {})
      source = options.fetch(:source)
      target = options.fetch(:target)
      begin
        @storage.fetch(target).fetch(source)
      rescue KeyError
        raise MapNotFound.new(self, source: source, target: target)
      end
    end

  end
end
