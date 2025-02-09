module NgWord
  class RuleList
    def initialize(rules)
      @rules = {}
      Array(rules).each do |rule|
        @rules[rule.ng_word.downcase] = rule
      end

      @regexp = Regexp.union(@rules.keys.map { |s| /#{s}/i })

      freeze
    end

    def verify(text)
      return VerificationResult.new(true) if text.blank?

      candidate_ng_words = text.scan(regexp)
      return VerificationResult.new(true) if candidate_ng_words.blank?

      downcased_text = text.downcase
      candidate_ng_words.each do |ng_word|
        rule = rules[ng_word.downcase]
        next if rule.blank?

        return VerificationResult.new(false, ng_word: rule.ng_word) if rule.match?(downcased_text)
      end

      VerificationResult.new(true)
    end

    def masked_text(text, replace_text: '***', for_monitoring: false)
      return text if text.blank?

      candidate_ng_words = text.scan(regexp)
      return text if candidate_ng_words.blank?

      candidate_ng_words.each do |ng_word|
        rule = rules[ng_word.downcase]
        next if rule.blank?

        text = rule.masked_text(text, replace_text: replace_text, for_monitoring: for_monitoring)
      end

      text
    end

    def match?(text)
      result = verify(text)
      !result.valid?
    end

    private

    attr_reader :rules, :regexp
  end
end
