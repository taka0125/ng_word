RSpec.describe NgWord::ExcludeWordRule do
  describe '#match?' do
    subject { NgWord::ExcludeWordRule.new(downcased_ng_word, exclude_word).match?(downcased_text, matched_index) }

    let(:downcased_ng_word) {}
    let(:exclude_word) {}
    let(:downcased_text) {}
    let(:matched_index) {}

    context 'match exclude_word' do
      let(:downcased_text) { 'This text is include ng word.' }
      let(:exclude_word) { 'ng word' }
      let(:downcased_ng_word) { 'ng' }
      let(:matched_index) { downcased_text.index(downcased_ng_word) }

      it { expect(subject).to be_truthy }
    end

    context 'not match exclude_word' do
      let(:downcased_text) { 'This text is include ng word.' }
      let(:exclude_word) { 'ng_word' }
      let(:downcased_ng_word) { 'ng' }
      let(:matched_index) { downcased_text.index(downcased_ng_word) }

      it { expect(subject).to be_falsy }
    end
  end
end
