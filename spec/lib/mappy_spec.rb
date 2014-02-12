require File.expand_path('../../../lib/mappy', __FILE__)

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
          target: 'orcid/work',
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
    let(:journal) {
      double('Journal', to_mappy_type: :journal, title: title)
    }

    subject { Mappy.map(journal, target: 'orcid/work') }

    its(:work_type) { should eq('long-journal')}
    its(:title) { should eq(title) }

  end
end
