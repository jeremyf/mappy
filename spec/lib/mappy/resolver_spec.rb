require File.expand_path('../../../../lib/mappy/resolver', __FILE__)
require 'ostruct'

module Mappy
  describe Resolver do
    let(:source_publisher) { lambda {|source| source.publishers.join("; ")}}
    let(:source) { double('Source', title: 'A Title', publishers: ["John", "Ringo"]) }
    let(:target_builder) { lambda {|attrs| OpenStruct.new(attrs) } }
    let(:legend) {
      [
        [:title, :title],
        [source_publisher, :publisher]
      ]
    }

    context '#call' do
      let(:resolved_publisher) { source_publisher.call(source) }
      subject { described_class.new(target_builder: target_builder, legend: legend).call(source) }

      its(:publisher) { should eq resolved_publisher }
      its(:title) { should eq source.title }
    end
  end
end
