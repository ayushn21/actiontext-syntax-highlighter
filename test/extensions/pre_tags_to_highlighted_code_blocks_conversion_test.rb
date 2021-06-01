# frozen_string_literal: true

require "test_helper"

module ActionTextSyntaxHighlighter
  class PreTagsToHighlightedCodeBlocksConversionTest < ActiveSupport::TestCase
    include ActionView::Helpers::SanitizeHelper

    test "existing pre tags in a rich text are converted to a highlighted attachment" do
      rich_text = action_text_rich_texts(:existing_pre_without_tags)
      body = rich_text.body
      rich_text.convert_pre_tags_to_highlighted_code_blocks

      assert rich_text.highlighted_code_blocks.first.content.present?
      assert_match rich_text.highlighted_code_blocks.first.content, rich_text.body.to_s
    end

    test "existing pre tags in a rich text with formatting tags are converted to a highlighted attachment" do
      rich_text = action_text_rich_texts(:existing_pre_with_tags)
      rich_text.convert_pre_tags_to_highlighted_code_blocks

      assert rich_text.highlighted_code_blocks.present?
      assert_match rich_text.highlighted_code_blocks.first.content, rich_text.body.to_s
      assert_equal strip_tags(rich_text.highlighted_code_blocks.first.content), rich_text.highlighted_code_blocks.first.content
    end
  end
end