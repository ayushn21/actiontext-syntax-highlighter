# frozen_string_literal: true

require "test_helper"

module ActionTextSyntaxHighlighter
  class RichTextHasHighlightedCodeBlockTest < ActiveSupport::TestCase
    setup do
      @post = posts(:three)
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)
      @post.update(content: attachment_fragment_for(code_block))
    end

    test "ActionText::RichText has an association for highlighted code blocks" do
      assert_equal 1, @post.content.highlighted_code_blocks.count
    end

    test "code blocks are updated before saving" do
      @post.update(content: "something else")

      assert_equal 0, @post.reload.content.highlighted_code_blocks.count
    end
  end
end