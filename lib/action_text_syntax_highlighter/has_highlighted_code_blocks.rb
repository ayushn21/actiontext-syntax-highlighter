# frozen_string_literal: true

module ActionTextSyntaxHighlighter
  module HasHighlightedCodeBlocks
    extend ActiveSupport::Concern

    included do
      has_many :highlighted_code_blocks, class_name: "ActionTextSyntaxHighlighter::HighlightedCodeBlock"
      before_save do
        self.highlighted_code_blocks = body.attachables.grep(ActionTextSyntaxHighlighter::HighlightedCodeBlock).uniq if body.present?
      end
    end
  end
end