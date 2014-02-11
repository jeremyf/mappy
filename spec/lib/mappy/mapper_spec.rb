require File.expand_path('../../../../lib/mappy/mapper', __FILE__)

module Mappy
  describe Mapper do

    let(:service_class) { double }

    describe 'with valid mapping block' do
      subject {
        Mapper.new(service_class) { |map|
          map.title :title
        }
      }
      let(:my_title) { 'abc' }
      let(:target) { double(title: my_title)}
      let(:identifier) { '123' }

      it { expect(subject.call(target)).to be_kind_of Mapper::Wrapper }
      it { expect(subject.call(target).extract_payload).to eq({ title: my_title }) }
    end

    describe Mapper::Wrapper do
      subject { Mapper::Wrapper.new(map, target) }

      context 'extract_payload' do
        let(:target) { double(foo: :foo_value) }
        describe 'with implicit getter' do
          let(:map) { double(_getters: { bar: :foo } ) }
          its(:extract_payload) { should == {bar: :foo_value} }
        end

        describe 'with lambda getter' do
          let(:map) { double(_getters: { bar: lambda {|o| o.foo } } ) }
          its(:extract_payload) { should == {bar: :foo_value} }
        end

        describe 'with implicit datastream getter' do
          let(:target) {
            double(datastreams: {'datastream' => double(foo: :foo_value)})
          }
          let(:map) {
            double(_getters: { foo: { at: 'datastream' } } )
          }
          its(:extract_payload) { should == {foo: :foo_value} }
        end

        describe 'with explicit datastream getter' do
          let(:target) {
            double(datastreams: {'datastream' => double(blorg: :foo_value)})
          }
          let(:map) {
            double(_getters: { foo: { at: 'datastream', in: :blorg } } )
          }
          its(:extract_payload) { should == {foo: :foo_value} }
        end

      end

      context '#extract_payload' do

        let(:target) { double(foo: :foo_value) }
        describe 'with implicit getter' do
          let(:map) { double(_getters: { bar: :foo } ) }
          its(:extract_payload) { should == {bar: :foo_value} }
        end

        describe 'with lambda getter' do
          let(:map) { double(_getters: { bar: lambda {|o| o.foo } } ) }
          its(:extract_payload) { should == {bar: :foo_value} }
        end

        describe 'with implicit datastream getter' do
          let(:target) {
            double(datastreams: {'datastream' => double(foo: :foo_value)})
          }
          let(:map) {
            double(_getters: { foo: { at: 'datastream' } } )
          }
          its(:extract_payload) { should == {foo: :foo_value} }
        end

        describe 'with explicit datastream getter' do
          let(:target) {
            double(datastreams: {'datastream' => double(blorg: :foo_value)})
          }
          let(:map) {
            double(_getters: { foo: { at: 'datastream', in: :blorg } } )
          }
          its(:extract_payload) { should == {foo: :foo_value} }
        end

      end

    end
  end
end
