require 'active_support/inflector'

module Mappy
  class TargetBuilderFactory
    def call(target_symbol)
      target_class = target_symbol.to_s.classify.constantize
      target_class.method(:new)
    end
  end
end