module NgWord
  class ExcludeWordRule
    def initialize(downcased_ng_word, exclude_word)
      @downcased_ng_word = downcased_ng_word
      @exclude_word = exclude_word
      @downcased_exclude_word = exclude_word.downcase

      @index = @downcased_exclude_word.index(@downcased_ng_word)
      @length = @downcased_exclude_word.length

      freeze
    end

    def match?(downcased_text, matched_index)
      downcased_text.slice(matched_index - index, length) == downcased_exclude_word
    end

    private

    attr_reader :downcased_ng_word, :exclude_word, :downcased_exclude_word, :index, :length
  end
end
