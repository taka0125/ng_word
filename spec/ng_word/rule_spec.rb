RSpec.describe NgWord::Rule do
  describe '#verify' do
    subject { NgWord::Rule.new(ng_word, exclude_words: exclude_words).verify(text.downcase) }

    let(:ng_word) {}
    let(:exclude_words) {}
    let(:text) { 'This text is include NG word.' }

    context 'text include ng word' do
      let(:ng_word) { 'ng' }

      context 'match exclude word' do
        let(:exclude_words) { ['ng word'] }
        it { expect(subject).to be_valid }
      end

      context 'not match exclude word' do
        let(:exclude_words) { [] }
        it { expect(subject).not_to be_valid }
      end
    end

    context 'text not include ng word' do
      let(:ng_word) { 'ngword' }
      it { expect(subject).to be_valid }
    end
  end

  describe '#masked_text' do
    subject { NgWord::Rule.new(ng_word, exclude_words: exclude_words).masked_text(text, for_monitoring: for_monitoring) }

    let(:ng_word) {}
    let(:exclude_words) {}
    let(:text) { 'This text is include NG word. ng word will masked.' }

    context 'for_monitoring = true' do
      let(:for_monitoring) { true }

      context 'text include ng word' do
        let(:ng_word) { 'ng' }

        context 'match exclude word' do
          let(:exclude_words) { ['ng word'] }
          it { expect(subject).to eq text }
        end

        context 'not match exclude word' do
          let(:exclude_words) { [] }
          it { expect(subject).to eq 'This text is include ***(ng) word. ***(ng) word will masked.' }
        end
      end

      context 'text not include ng word' do
        let(:ng_word) { 'ngword' }
        it { expect(subject).to eq text }
      end
    end

    context 'for_monitoring = true' do
      let(:for_monitoring) { false }

      context 'text include ng word' do
        let(:ng_word) { 'ng' }

        context 'match exclude word' do
          let(:exclude_words) { ['ng word'] }
          it { expect(subject).to eq text }
        end

        context 'not match exclude word' do
          let(:exclude_words) { [] }
          it { expect(subject).to eq 'This text is include *** word. *** word will masked.' }
        end
      end

      context 'text not include ng word' do
        let(:ng_word) { 'ngword' }
        it { expect(subject).to eq text }
      end
    end
  end

  describe '#match?' do
    subject { NgWord::Rule.new(ng_word, exclude_words: exclude_words).match?(text.downcase) }

    let(:ng_word) {}
    let(:exclude_words) {}
    let(:text) { 'This text is include NG word.' }

    context 'text include ng word' do
      let(:ng_word) { 'ng' }

      context 'match exclude word' do
        let(:exclude_words) { ['ng word'] }
        it { expect(subject).to be_falsy }
      end

      context 'not match exclude word' do
        let(:exclude_words) { [] }
        it { expect(subject).to be_truthy }
      end
    end

    context 'text not include ng word' do
      let(:ng_word) { 'ngword' }
      it { expect(subject).to be_falsy }
    end
  end
end
