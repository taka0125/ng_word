RSpec.describe NgWord::RuleList do
  describe '#verify' do
    subject { NgWord::RuleList.new(rule_list).verify(text) }
  end

  describe '#masked_text' do
    subject { NgWord::RuleList.new(rule_list).masked_text(text, for_monitoring: true) }

    let(:text) { 'This text is include NG word and hoge word.' }

    context 'text include multiple ng word' do
      context 'first word match exclude word' do
        context 'second word match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: ['ng word']),
              NgWord::Rule.new('hoge', exclude_words: ['hoge word'])
            ]
          end

          it { expect(subject).to eq text }
        end

        context 'second word not match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: ['ng word']),
              NgWord::Rule.new('hoge', exclude_words: [])
            ]
          end

          it { expect(subject).to eq 'This text is include NG word and ***(hoge) word.' }
        end
      end

      context 'first word not match exclude word' do
        context 'second word match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: []),
              NgWord::Rule.new('hoge', exclude_words: ['hoge word'])
            ]
          end

          it { expect(subject).to eq 'This text is include ***(ng) word and hoge word.' }
        end

        context 'second word not match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: []),
              NgWord::Rule.new('hoge', exclude_words: [])
            ]
          end

          it { expect(subject).to eq 'This text is include ***(ng) word and ***(hoge) word.' }
        end
      end
    end

    context 'text not include ng word' do
      let(:rule_list) do
        [
          NgWord::Rule.new('hogehoge', exclude_words: []),
          NgWord::Rule.new('fugafuga', exclude_words: [])
        ]
      end

      it { expect(subject).to eq text }
    end
  end

  describe '#match?' do
    subject { NgWord::RuleList.new(rule_list).match?(text) }

    let(:text) { 'This text is include NG word and hoge word.' }

    context 'text include multiple ng word' do
      context 'first word match exclude word' do
        context 'second word match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: ['ng word']),
              NgWord::Rule.new('hoge', exclude_words: ['hoge word'])
            ]
          end

          it { expect(subject).to be_falsy }
        end

        context 'second word not match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: ['ng word']),
              NgWord::Rule.new('hoge', exclude_words: [])
            ]
          end

          it { expect(subject).to be_truthy }
        end
      end

      context 'first word not match exclude word' do
        context 'second word match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: []),
              NgWord::Rule.new('hoge', exclude_words: ['hoge word'])
            ]
          end

          it { expect(subject).to be_truthy }
        end

        context 'second word not match exclude word' do
          let(:rule_list) do
            [
              NgWord::Rule.new('ng', exclude_words: []),
              NgWord::Rule.new('hoge', exclude_words: [])
            ]
          end

          it { expect(subject).to be_truthy }
        end
      end
    end

    context 'text not include ng word' do
      let(:rule_list) do
        [
          NgWord::Rule.new('hogehoge', exclude_words: []),
          NgWord::Rule.new('fugafuga', exclude_words: [])
        ]
      end

      it { expect(subject).to be_falsy }
    end
  end
end
