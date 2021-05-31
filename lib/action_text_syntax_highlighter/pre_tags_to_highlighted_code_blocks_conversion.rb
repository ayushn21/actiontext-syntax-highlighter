module ActionTextSyntaxHighlighter
  module PreTagsToHighlightedCodeBlocksConversion

    def convert_pre_tags_to_highlighted_code_blocks
      @document = Nokogiri::HTML::DocumentFragment.parse(body.to_html)
      @document.css("pre").each do |node|
        code_block_content = sanitizer.sanitize node.inner_html
        code_block = ActionText::HighlightedCodeBlock.create(content: code_block_content)
        node.swap attachment_node_for(code_block)
      end

      update(body: @document.to_s)
    end

    private
      def attachment_node_for(code_block)
        attachment_node = Nokogiri::XML::Node.new(attachment_tag_name, @document)
        attachment_node[:"content-type"] = "text/html"
        attachment_node[:sgid] = code_block.attachable_sgid
        attachment_node
      end

      def attachment_tag_name
        ActionText::Attachment.try(:tag_name) || ActionText::Attachment::TAG_NAME
      end

      def sanitizer
        @sanitizer ||= Rails::Html::FullSanitizer.new
      end
  end
end