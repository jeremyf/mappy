require File.expand_path('../../../../lib/mappy/configuration', __FILE__)

module Mappy
  describe Configuration do
    let(:registration_builder) { double('Builder') }
    let(:registration) { double("Registration") }
    let(:target_name) { :petunias }
    subject { described_class.new(registration_builder: registration_builder) }

    context '#to_target' do
      before(:each) do
        registration_builder.should_receive(:call).with(target_name).and_return(registration)
      end
      it 'should yield the registration' do
        expect {|b| subject.to_target(target_name, &b) }.to yield_with_args(registration)
      end

      it 'should return the configuration' do
        expect( subject.to_target(target_name) ).to eq(subject)
      end
    end

    context '#map' do
      let(:mapper) { double("Mapper") }
      let(:target) { double("Target") }
      let(:source) { double("Source") }
      it 'should call the mapper' do
        mapper.should_receive(:call).with(source, target).and_return(:response)
        expect(subject.map(source, to: target, mapper: mapper)).to eq(:response)
      end
    end
  end
end
