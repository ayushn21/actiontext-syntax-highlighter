var __defProp = Object.defineProperty;
var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
var __publicField = (obj, key, value) => {
  __defNormalProp(obj, typeof key !== "symbol" ? key + "" : key, value);
  return value;
};
import { HighlightedCodeBlock } from "./highlighted_code_block";
import { TrixCodeBlockHighlighter } from "./trix_code_block_highlighter";
import css from "../css/highlighted_code_block.css";
export class ActionTextSyntaxHighlighter {
  static start() {
    customElements.define("highlighted-code-block", HighlightedCodeBlock);
    document.addEventListener("trix-initialize", (event) => {
      if (event.target.dataset.highlightsCodeBlocks) {
        new TrixCodeBlockHighlighter(event.target);
      }
    });
  }
}
__publicField(ActionTextSyntaxHighlighter, "basePath", "/rails/action_text/highlighted_code_blocks");
