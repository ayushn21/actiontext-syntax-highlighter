# frozen_string_literal: true

namespace :action_text_syntax_highlighter do
  task :install do
    Rake::Task["action_text_syntax_highlighter:install:migrations"].execute
    puts "Install yarn package..."
    # `yarn add @ayushn21/action_text_syntax_highlighter`

    puts "All done! Just add the following lines to your JavaScript application:"
    puts ""
    puts <<~JAVASCRIPT
      import { ActionTextSyntaxHighlighter } from "@ayushn21/actiontext-syntax-highlighter"
      ActionTextSyntaxHighlighter.start()
    JAVASCRIPT

    puts ""
  end
end