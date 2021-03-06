Rails.application.routes.draw do
  scope ActionTextSyntaxHighlighter.routes_prefix do
    post "/highlighted_code_blocks", to: "action_text_syntax_highlighter/highlighted_code_blocks#create"
    patch "/highlighted_code_blocks/:id", to: "action_text_syntax_highlighter/highlighted_code_blocks#update", as: "highlighted_code_block"
  end
end if ActionTextSyntaxHighlighter.draw_routes