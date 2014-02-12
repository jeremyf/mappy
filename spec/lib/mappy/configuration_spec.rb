require File.expand_path('../../../../lib/mappy/configuration', __FILE__)

module Mappy
  describe Configuration do
    let(:map_store) { {} }
    let(:legend) { [[:title, :title]] }

    subject { described_class.new(map_store: map_store) }

    context '#legend' do
      it 'should yield a map storage' do
        subject.legend(source: :article, target: :document, legend: legend)
        expect(map_store.fetch(:document).fetch(:article)).to eq(legend)
      end
    end

    context '#map' do
      let(:source_type) {:article}
      let(:article) { double('Article', title: 'Hello', to_mappy_type: source_type) }
      let(:target_builder) { OpenStruct.method(:new)}
      let(:target_type) { :document }
      let(:target_builder_finder) { double("Finder") }

      before(:each) do
        subject.legend(source: source_type, target: target_type, legend: legend)
      end
      it 'should yield a map storage' do
        target_builder_finder.should_receive(:call).with(target_type).and_return(target_builder)

        document = subject.map(article, target: target_type, target_builder_finder: target_builder_finder)
        expect(document.title).to eq(article.title)
      end
    end
  end
end
