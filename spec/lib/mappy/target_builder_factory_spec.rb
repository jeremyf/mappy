require File.expand_path('../../../../lib/mappy/target_builder_factory', __FILE__)
require File.expand_path('../../model_support', __FILE__)

module Mappy
  describe TargetBuilderFactory do
    subject { described_class.new }

    context '.call' do
      it 'returns a builder lambda based on the input' do
        expect(described_class.call('mappy/mock_valid_model')).to respond_to(:new)
      end
    end

    context '#call' do
      it 'returns a builder lambda based on the input' do
        expect(subject.call('mappy/mock_valid_model')).to respond_to(:new)
      end

      it 'raises an exception when the builder does not have attributes' do
        expect {
          subject.call('mappy/mock_invalid_model')
        }.to raise_error
      end

    end
  end
end
