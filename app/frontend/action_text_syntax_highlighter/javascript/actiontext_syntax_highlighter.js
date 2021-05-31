import { HighlightedCodeBlock } from "./highlighted_code_block"
import { TrixCodeBlockHighlighter } from "./trix_code_block_highlighter"

export class ActionTextSyntaxHighlighter {
  static basePath = "/action_text/highlighted_code_blocks"

  static start() {
    customElements.define('highlighted-code-block', HighlightedCodeBlock)

    document.addEventListener("trix-initialize", (event) => {
      if (event.target.dataset.highlightsCodeBlocks) {
        new TrixCodeBlockHighlighter(event.target)
      }
    })
  }
}
