require File.expand_path('../../../../lib/mappy/configuration', __FILE__)

module Mappy
  describe Configuration do
    let(:map_store) { {} }
    let(:map) { lambda{|m| m << [:title, :title] } }

    subject { described_class.new(map_store: map_store) }

    context '#legend' do
      it 'should yield a map storage' do
        subject.legend(source: :article, target: :document, &map)
        expect(map_store.fetch(:document).fetch(:article)).to eq(map)
      end
    end

    context '#map' do
      let(:source_type) {:article}
      let(:article) { double('Article', to_mappy_type: source_type) }
      before(:each) do
        subject.legend(source: source_type, target: :document, &map)
      end
      it 'should yield a map storage' do
        document = subject.map(article, target: :document)
        expect(document.title).to eq(article.title)
      end
    end
  end
end
