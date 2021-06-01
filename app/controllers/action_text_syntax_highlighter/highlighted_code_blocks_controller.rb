# frozen_string_literal: true

module ActionTextSyntaxHighlighter
  class HighlightedCodeBlocksController < ApplicationController
    def create
      @code_block = HighlightedCodeBlock.create
      render json: {
        sgid: @code_block.attachable_sgid,
        contentType: "text/html",
        content: render_to_string(
          partial: @code_block.to_trix_content_attachment_partial_path,
          locals: { highlighted_code_block: @code_block },
          formats: [:html]
        )
      }, status: :created
    end

    def update
      @code_block = ActionText::Attachable.from_attachable_sgid params[:id]
      @code_block.update(code_block_params)
      head :no_content
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    private
      def code_block_params
        params.require(:highlighted_code_block).permit(:content, :language)
      end
  end
end