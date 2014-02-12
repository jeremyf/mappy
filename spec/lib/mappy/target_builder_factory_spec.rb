require File.expand_path('../../../../lib/mappy/target_builder_factory', __FILE__)

module Mappy
  class MockModel
  end

  describe TargetBuilderFactory do
    subject { Mappy::TargetBuilderFactory.new }

    context '#call' do
      it 'returns a builder lambda based on the input' do
        expect(subject.call('mappy/mock_model')).to respond_to(:call)
      end
    end
  end
end
