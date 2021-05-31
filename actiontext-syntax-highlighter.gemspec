require_relative "lib/actiontext/syntax/highlighter/version"

Gem::Specification.new do |spec|
  spec.name        = "actiontext-syntax-highlighter"
  spec.version     = ActionTextSyntaxHighlighter::VERSION
  spec.authors     = ["Ayush Newatia"]
  spec.email       = ["ayush@hey.com"]
  spec.homepage    = "https://github.com/ayushn21/actiontext-syntax-highlighter"
  spec.summary     = "TODO: Summary of Actiontext::Syntax::Highlighter."
  spec.description = "TODO: Description of Actiontext::Syntax::Highlighter."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  spec.files = Dir["{app,config,db,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  spec.add_dependency "rails", ">= 6.0"
  spec.add_dependency "rouge"
end
