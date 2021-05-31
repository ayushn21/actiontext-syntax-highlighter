module ActionTextSyntaxHighlighter
  class PurgeDeletedHighlightedCodeBlocksJob < ApplicationJob
    queue_as :default

    def perform
      HighlightedCodeBlock.deleted.find_each do |code_block|
        code_block.destroy
      end
    end
  end
end