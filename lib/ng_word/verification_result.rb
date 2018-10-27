module NgWord
  class VerificationResult
    attr_reader :ng_word

    def initialize(is_valid, ng_word: nil)
      @is_valid = is_valid
      @ng_word = ng_word
    end

    def valid?
      @is_valid
    end
  end
end
