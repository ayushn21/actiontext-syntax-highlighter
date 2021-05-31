Rails.application.routes.draw do
  scope ActionTextSyntaxHighlighter.routes_prefix do
    post "/highlighted_code_blocks", to: "action_text_syntax_highlighter/highlighted_code_blocks#create"
    patch "/highlighted_code_blocks", to: "action_text_syntax_highlighter/highlighted_code_blocks#update"
  end
end if ActionTextSyntaxHighlighter.draw_routes