class ActionTextSyntaxHighlighter::HighlightedCodeBlock < ApplicationRecord
  include ActionText::Attachable, SupportedLanguages

  self.table_name = "action_text_highlighted_code_blocks"

  belongs_to :rich_text, class_name: "ActionText::RichText", optional: true

  before_save :process_content

  scope :deleted, -> { where(rich_text_id: nil).and(where(updated_at: ..1.day.ago)) }

  def language
    super || ""
  end

  def highlighted_content
    return content unless lexer.present?

    highlighter.format(lexer.lex(content)).html_safe
  end

  def content_type
    "text/html"
  end

  def to_trix_content_attachment_partial_path
    "action_text/highlighted_code_blocks/editor"
  end

  private
    def process_content
      self.content&.gsub!(/<br>/, "\n")
    end

    def highlighter
      @highlighter ||= Rouge::Formatters::HTML.new
    end

    def lexer
      @lexer ||= begin
        if language.present?
          Rouge::Lexer.find(language.downcase).new
        else
          Rouge::Lexer.guesses(source: content).first&.new
        end
      end
    end
end
