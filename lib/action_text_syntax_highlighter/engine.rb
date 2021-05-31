module ActionTextSyntaxHighlighter
  class Engine < ::Rails::Engine

    config.action_text_syntax_highlighter = ActiveSupport::OrderedOptions.new

    initializer "action_text_syntax_highlighter.allow_theme_attribute" do
      Rails.application.config.to_prepare do
        ActionText::ContentHelper.allowed_attributes << "data-theme"
      end
    end

    initializer "action_text_syntax_highlighter.configs" do
      config.after_initialize do |app|
        ActionTextSyntaxHighlighter.draw_routes   = app.config.action_text_syntax_highlighter.draw_routes != false
        ActionTextSyntaxHighlighter.routes_prefix = app.config.action_text_syntax_highlighter.routes_prefix || "/rails/action_text"
        ActionTextSyntaxHighlighter.default_theme = app.config.action_text_syntax_highlighter.default_theme || :github
      end
    end

    initializer "action_text_syntax_highlighter.rich_text_includes" do
      ActiveSupport.on_load(:action_text_rich_text) do
        include ActionTextSyntaxHighlighter::HasHighlightedCodeBlocks
        include ActionTextSyntaxHighlighter::PreTagsToHighlightedCodeBlocksConversion
      end
    end
  end
end
