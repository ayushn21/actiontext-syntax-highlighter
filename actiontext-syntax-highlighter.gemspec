require_relative "lib/action_text_syntax_highlighter/version"

Gem::Specification.new do |spec|
  spec.name        = "actiontext-syntax-highlighter"
  spec.version     = ActionTextSyntaxHighlighter::VERSION
  spec.authors     = ["Ayush Newatia"]
  spec.email       = ["ayush@hey.com"]
  spec.homepage    = "https://github.com/ayushn21/actiontext-syntax-highlighter"
  spec.summary     = "Extends ActionText to support highlighed code blocks"
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ayushn21/actiontext-syntax-highlighter"
  spec.metadata["changelog_uri"] = "https://github.com/ayushn21/actiontext-syntax-highlighter/blob/main/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]
  spec.require_path = "lib"

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "rouge"
end
