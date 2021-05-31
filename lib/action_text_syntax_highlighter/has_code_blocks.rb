module ActionText
  module HasCodeBlocks
    extend ActiveSupport::Concern

    included do
      has_many :highlighted_code_blocks, class_name: "ActionText::HighlightedCodeBlock"
      before_save do
        self.highlighted_code_blocks = body.attachables.grep(ActionText::HighlightedCodeBlock).uniq if body.present?
      end
    end
  end
end