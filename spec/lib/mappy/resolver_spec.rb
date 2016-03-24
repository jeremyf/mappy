require 'spec_helper'
require 'mappy/resolver'
require 'ostruct'

module Mappy
  describe Resolver do
    let(:target_builder) { OpenStruct }
    let(:legend) {
      [
        [:title, :title],
        [source_publisher, :publisher]
      ]
    }
    let(:source_publisher) { lambda {|source| source.publishers.join("; ")}}
    subject { described_class.new(target_builder: target_builder, legend: legend).call(source) }

    context '#call' do
      context 'source is not an instance of the target builder' do
        let(:source) { double('Source', title: 'A Title', publishers: ["John", "Ringo"]) }
        let(:resolved_publisher) { source_publisher.call(source) }

        it 'should return an instance of the target_builder' do
          expect(subject).to be_an_instance_of(target_builder)
        end

        its(:publisher) { should eq resolved_publisher }
        its(:title) { should eq source.title }
      end

      context 'source is an instance of the target builder' do
        let(:source) { target_builder.new(publisher: 'Hello', title: 'World') }

        it 'should return the unaltered source' do
          expect(subject).to eq source
        end
        its(:publisher) { should eq source.publisher }
        its(:title) { should eq source.title }
      end
    end
  end
end
