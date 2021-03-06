# frozen_string_literal: true

require "active_support"
require "active_support/rails"
require "nokogiri"
require "rouge"

module ActionTextSyntaxHighlighter
  extend ActiveSupport::Autoload

  autoload :HasHighlightedCodeBlocks
  autoload :PreTagsToHighlightedCodeBlocksConversion

  mattr_accessor :draw_routes, default: true
  mattr_accessor :routes_prefix, default: "/rails/action_text"
  mattr_accessor :default_theme, default: :github
end