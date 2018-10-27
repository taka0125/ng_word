module NgWord
  class ExcludeWordRule
    def initialize(downcased_ng_word, exclude_word)
      @downcased_ng_word = downcased_ng_word
      @exclude_word = exclude_word
    end

    def match?(downcased_text, matched_index)
      downcased_text.slice(matched_index - index, length) == @downcased_exclude_word
    end

    private

    def downcased_exclude_word
      @downcased_exclude_word ||= @exclude_word.downcase
    end

    def index
      @index ||= downcased_exclude_word.index(@downcased_ng_word)
    end

    def length
      @length ||= downcased_exclude_word.length
    end
  end
end
