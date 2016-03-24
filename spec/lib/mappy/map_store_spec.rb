require 'spec_helper'
require 'mappy/map_store'

module Mappy
  describe MapStore do
    subject { described_class.new }

    context 'write/read' do
      let(:source) { double('Source')}
      let(:target) { double('Target')}
      let(:legend) { double('Legend')}
      it 'should read the written values' do
        subject.write(source: source, target: target, legend: legend)
        expect(subject.read(source: source, target: target)).to eq(legend)
      end

      it 'should raise an error when attempting to write missing options' do
        expect { subject.write }.to raise_error KeyError
      end

      it 'should raise an error when attempting to write missing options' do
        expect { subject.read(source: source, target: target) }.to raise_error Mappy::MapNotFound
      end
    end
  end
end
