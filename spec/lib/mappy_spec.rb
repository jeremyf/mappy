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
        config.legend(source: :journal, target: 'orcid/work') do
          title :title
          work_type 'long-journal'
        end
      end
    end
    after(:each) do
      Mappy.reset!
    end

    let(:title) { 'A Rocking Title' }
    let(:contributors) { ["John", "Paul", "Ringo", "George"] }
    let(:journal) {
      double('Journal', to_mappy_type: :journal, title: title, contributors: contributors)
    }

    subject { Mappy.map(journal, to: 'orcid/work') }

    its(:work_type) { should eq('long-journal')}
    its(:title) { should title }
    its(:contributor) { should eq contributors.join("; ") }
  end
end
