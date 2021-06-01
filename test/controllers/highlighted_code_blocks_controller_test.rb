# frozen_string_literal: true

require "test_helper"

module ActionTextSyntaxHighlighter
  class HighlightedCodeBlocksControllerTest < ActionDispatch::IntegrationTest

    test "new code block path creates the record and returns valid json" do
      assert_difference("ActionTextSyntaxHighlighter::HighlightedCodeBlock.count", 1) do
        post highlighted_code_blocks_path
      end

      json = JSON.parse(response.body).with_indifferent_access

      assert_response :created

      assert_equal HighlightedCodeBlock.last, ActionText::Attachable.from_attachable_sgid(json[:sgid])
      assert_equal "text/html", json[:contentType]
      assert_match "<select", json[:content]
      assert_match "<option", json[:content], count: Rouge::Lexer.all.count + 1
      assert_match "<pre contenteditable", json[:content]
    end

    test "update code block path updates the record and returns no content" do
      post highlighted_code_blocks_path
      sgid = JSON.parse(response.body)["sgid"]

      patch highlighted_code_block_path(sgid), params: {
        highlighted_code_block: {
          language: "Ruby",
          content: "say 'Houston, we have a problem.'"
        }
      }

      code_block = ActionText::Attachable.from_attachable_sgid(sgid)
      assert_response :no_content
      assert_equal "Ruby", code_block.language
      assert_equal "say 'Houston, we have a problem.'", code_block.content
    end

    test "update code block path with invalid id returns a 404 error" do
      patch highlighted_code_block_path("invalid"), params: {
        highlighted_code_block: {
          language: "Ruby",
          content: "say 'Houston, we have a problem.'"
        }
      }

      assert_response :not_found
    end
  end
end
