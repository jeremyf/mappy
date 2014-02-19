module Mappy
  class MockValidModel
    attr_accessor :title, :work_type
    def initialize(attributes)
      attributes.each_pair do |key, value|
        send("#{key}=", value) if respond_to?("#{key}=")
      end
    end
  end

  class MockInvalidModel
  end

  class WithoutExplicitMappyType
  end
end
