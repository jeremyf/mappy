require File.expand_path('../../../../lib/mappy/target_builder_factory', __FILE__)

module Mappy
  class MockValidModel
    attr_accessor :attributes
    def initialize(attributes)
    end
  end

  class MockNoAttributesModel
  end

  class MockImproperInitializeMethodSignatureModel
    attr_accessor :attributes
  end

  describe TargetBuilderFactory do
    subject { Mappy::TargetBuilderFactory.new }

    context '#call' do
      it 'returns a builder lambda based on the input' do
        expect(subject.call('mappy/mock_valid_model')).to respond_to(:new)
      end

      it 'raises an exception when the builder does not have attributes' do
        expect {
          subject.call('mappy/mock_no_attributes_model')
        }.to raise_error
      end

      it 'raises an exception when the builder initialize does not take a hash' do
        expect {
          subject.call('mappy/mock_improper_initialize_method_signature_model')
        }.to raise_error
      end
    end
  end
end
