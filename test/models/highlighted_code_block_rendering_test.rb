# frozen_string_literal: true

require "test_helper"

module ActionTextSyntaxHighlighter
  class HighlightedCodeBlockRenderingTest < ActiveSupport::TestCase
    include ActionView::Helpers::SanitizeHelper

    setup do
      @post = posts(:two)
    end

    test "renders attachment in a pre tag without formatting" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:missing_language)
      @post.update(content: attachment_fragment_for(code_block))

      attachment = parse_fragment(@post.content.body.to_trix_html)
      code_block_content = attachment.at_css("pre").inner_html

      assert_equal strip_tags(code_block_content), code_block_content
    end

    test "renders attachment with language selected in select element" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)
      @post.update(content: attachment_fragment_for(code_block))

      attachment = parse_fragment(@post.content.body.to_trix_html)
      assert_equal "Ruby", attachment.at_css("option[selected]")["value"]
    end

    test "renders content in a single pre tag" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)
      @post.update(content: attachment_fragment_for(code_block))

      content = Nokogiri::HTML::DocumentFragment.parse(@post.content.to_s)
      assert_equal 1, content.css("pre").count
    end

    test "renders content with default theme attribute" do
      code_block = action_text_syntax_highlighter_highlighted_code_blocks(:ruby)
      @post.update(content: attachment_fragment_for(code_block))

      content = Nokogiri::HTML::DocumentFragment.parse(@post.content.to_s)
      assert_equal "github", content.at_css("pre")["data-theme"]

      ActionTextSyntaxHighlighter.default_theme = :base16

      content = Nokogiri::HTML::DocumentFragment.parse(@post.content.to_s)
      assert_equal "base16", content.at_css("pre")["data-theme"]
    end

    private

    def parse_fragment(html)
      figure = Nokogiri::HTML::DocumentFragment.parse(html)
      attachment = JSON.parse(figure.at_css("figure")["data-trix-attachment"])
      Nokogiri::HTML::DocumentFragment.parse(attachment["content"])
    end
  end
end