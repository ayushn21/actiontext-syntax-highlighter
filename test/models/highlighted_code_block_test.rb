# frozen_string_literal: true

require "test_helper"

module ActionTextSyntaxHighlighter
  class HighlightedCodeBlockTest < ActiveSupport::TestCase
    test "returns highlighted content for content as per language" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)

      assert_match "<span class=", code_block.highlighted_content, count: 5
    end

    test "tries to guess language if it's missing" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:guessed_language)

      assert_match "<span class=", code_block.highlighted_content, count: 2
    end

    test "returns content without highlighting if language cannot be guessed" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:missing_language)

      assert_no_match "<span class=", code_block.highlighted_content
    end

    test "removes br tags before saving" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby_with_br)
      code_block.save

      assert_no_match "<br>", code_block.highlighted_content
    end

    test "blocks without a rich text and older than one day are considered deleted" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby_without_rich_text)

      assert_equal 0, HighlightedCodeBlock.deleted.count
      travel_to 25.hours.from_now
      assert HighlightedCodeBlock.deleted.include? code_block
    end

    test "block with a rich text are not considered deleted" do
      rich_text = action_text_rich_texts(:one)
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)

      code_block.update(rich_text: rich_text)

      travel_to 7.days.from_now
      assert_not HighlightedCodeBlock.deleted.include? code_block
    end

    test "code block is deleted when rich text is deleted" do
      rich_text = action_text_rich_texts(:one)
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)

      code_block.update(rich_text: rich_text)

      rich_text.destroy
      assert_not HighlightedCodeBlock.exists?(code_block.id)
    end

    test "supported languages are created as required" do
      assert_equal "", HighlightedCodeBlock.supported_languages.first
      assert_equal Rouge::Lexer.all.count, HighlightedCodeBlock.supported_languages.count - 1
    end

    private
      def code_block
        @code_block ||= ActionTextSyntaxHighlighter::HighlightedCodeBlock.new(
          language: @language,
          content: @content
        )
      end
  end
end