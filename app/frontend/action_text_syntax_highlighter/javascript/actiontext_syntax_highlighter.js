import { HighlightedCodeBlock } from "./highlighted_code_block"
import { TrixCodeBlockHighlighter } from "./trix_code_block_highlighter"
import css from "../css/highlighted_code_block.css"

export class ActionTextSyntaxHighlighter {
  static basePath = "/rails/action_text/highlighted_code_blocks"

  static start() {
    customElements.define('highlighted-code-block', HighlightedCodeBlock)

    document.addEventListener("trix-initialize", (event) => {
      if (event.target.dataset.highlightsCodeBlocks) {
        new TrixCodeBlockHighlighter(event.target)
      }
    })
  }
}
