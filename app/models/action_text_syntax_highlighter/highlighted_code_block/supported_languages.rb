module ActionTextSyntaxHighlighter::HighlightedCodeBlock::SupportedLanguages
  extend ActiveSupport::Concern

  class_methods do
    def supported_languages
      @supported_languages ||= Rouge::Lexer.all.map do |lexer|
        lexer.to_s.split("::").last
      end.sort.unshift("")
    end
  end
end