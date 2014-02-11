require File.expand_path('../../../../lib/mappy/target_registration', __FILE__)

module Mappy
  describe TargetRegistration do
    let(:target_name) { :target }
    subject { described_class.new(target_name) }

    context '#from_source' do
      it 'requires a map' do
        expect { subject.from_source(:source) }.to raise_error
      end
    end

    context '#call' do
      let(:map) { lambda {|*args| } }
      let(:source_type) { :journal }
      let(:source) { double("Source") }
      subject { described_class.new(target_name) }

      before(:each) do
        subject.from_source(source_type, &map)
      end

      it 'should retrieve the map and call it' do
        Mappy.should_receive(:to_type).with(source).and_return(source_type)
        map.should_receive(:call).with(source_type, source)
        subject.call(source, target_name)
      end
    end
  end
end
