require 'spec_helper'
require 'mappy'
require File.expand_path('../model_support', __FILE__)

describe Mappy do
  context '.to_type' do

    it 'with explicit to mappy type' do
      object = double(to_mappy_type: 'hello-world')
      expect(Mappy.to_type(object)).to eq('hello-world')
    end

    it 'without explicit to mappy type' do
      object = Mappy::WithoutExplicitMappyType.new
      expect(Mappy.to_type(object)).to eq('mappy/without_explicit_mappy_type')
    end

  end

  context '.map' do
    before(:each) do
      Mappy.configure do |config|
        config.register(
          source: :journal,
          target: 'mappy/mock_valid_model',
          legend: [
            [:title, :title],
            [lambda{|*|'long-journal'}, :work_type],
          ]
        )
      end
    end
    after(:each) do
      Mappy.reset!
    end

    let(:title) { 'A Rocking Title' }
    let(:journal) { double('Journal', to_mappy_type: :journal, title: title) }

    context 'with a full source to target map' do
      subject { Mappy.map(journal, target: 'mappy/mock_valid_model') }

      its(:work_type) { should eq('long-journal')}
      its(:title) { should eq(title) }
    end

  end
end
