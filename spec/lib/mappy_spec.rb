require File.expand_path('../../../lib/mappy', __FILE__)
require File.expand_path('../model_support', __FILE__)

describe Mappy do
  context '.to_type' do
    let(:mappy_type) { 'hello-world' }
    let(:object) { double(to_mappy_type: mappy_type)}
    it 'with explicit to mappy type' do
      expect(Mappy.to_type(object)).to eq(mappy_type)
    end
  end

  context '.map' do
    before(:each) do
      Mappy.configure do |config|
        config.legend(
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
