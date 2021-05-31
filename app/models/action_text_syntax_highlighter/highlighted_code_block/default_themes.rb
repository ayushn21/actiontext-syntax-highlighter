module ActionTextSyntaxHighlighter::HighlightedCodeBlock::DefaultThemes
  extend ActiveSupport::Concern

  included do
    class_attribute :default_theme, instance_writer: false, default: :github
  end
end