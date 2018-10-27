module NgWord
  class Rule
    attr_reader :ng_word, :exclude_word_rules

    def initialize(ng_word, exclude_words: [])
      @ng_word = ng_word
      @exclude_words = exclude_words
    end

    def verify(downcased_text, offset: 0)
      index = downcased_text.index(downcased_ng_word, offset)
      return VerificationResult.new(true) if index.nil?

      exclude_word_rules.each do |rule|
        return verify(downcased_text, offset: index + 1) if rule.match?(downcased_text, index)
      end

      VerificationResult.new(false, ng_word: @ng_word)
    end

    def masked_text(text, replace_text: '***', for_monitoring: false)
      downcased_text = text.downcase
      index = downcased_text.index(downcased_ng_word)
      return text if index.nil?

      index_list = split(downcased_text)

      words = []
      current_index = 0
      index_list.each do |index|
        words << text.slice(current_index, index - current_index)
        current_index = index + downcased_ng_word.length
      end
      words << text.slice(current_index, text.length - current_index)

      replaced_text = for_monitoring ? "#{replace_text}(#{@ng_word})" : replace_text
      words.join(replaced_text)
    end

    def match?(downcased_text)
      result = verify(downcased_text)
      !result.valid?
    end

    private

    def downcased_ng_word
      @downcased_ng_word ||= @ng_word.downcase
    end

    def exclude_word_rules
      @exclude_word_rules ||= Array(@exclude_words).map { |w| ExcludeWordRule.new(downcased_ng_word, w) }
    end

    def split(downcased_text, offset: 0, index_list: [])
      index = downcased_text.index(downcased_ng_word, offset)
      return index_list if index.nil?

      exclude_word_rules.each do |rule|
        return split(downcased_text, offset: index + 1, index_list: index_list) if rule.match?(downcased_text, index)
      end

      split(downcased_text, offset: index + 1, index_list: index_list + [index])
    end
  end
end
