import { ActionTextSyntaxHighlighter } from "./actiontext_syntax_highlighter";
import { getDefaultHeaders } from "./helpers";
export class TrixCodeBlockHighlighter {
  constructor(element) {
    this.element = element;
    this.editor = element.editor;
    this.setup();
  }
  addCodeBlock(event) {
    fetch(ActionTextSyntaxHighlighter.basePath, {
      method: "POST",
      headers: getDefaultHeaders()
    }).then((response) => response.json()).then((result) => this.insertCodeBlock(result));
  }
  saveCodeBlock(block, sgid) {
    fetch(`${ActionTextSyntaxHighlighter.basePath}/${sgid}`, {
      method: "PATCH",
      headers: getDefaultHeaders(),
      body: block
    });
  }
  insertCodeBlock(block) {
    let attachment = new Trix.Attachment(block);
    this.editor.insertAttachment(attachment);
    this.editor.composition.editAttachment(attachment);
  }
  setup() {
    var _a;
    this.editorToolbar.setAttribute("data-highlights-code-blocks", "");
    this.editor.syntaxHighlighter = this;
    this.interceptToolbarCodeButton();
    this.watchCursor();
    (_a = this.element.querySelector("highlighted-code-block")) == null ? void 0 : _a.setup();
  }
  interceptToolbarCodeButton() {
    this.editorToolbarCodeButton.addEventListener("mousedown", (event) => {
      this.addCodeBlock();
      event.preventDefault();
      event.stopImmediatePropagation();
    });
  }
  watchCursor() {
    this.element.addEventListener("trix-selection-change", (event) => {
      this.updateToolbarState(this.editor.getPosition());
    });
  }
  updateToolbarState(position) {
    var _a;
    let attachmentType = (_a = this.editor.getDocument().getPieceAtPosition(position).attachment) == null ? void 0 : _a.type;
    if (attachmentType == "HighlightedCodeBlock") {
      this.editorToolbarCodeButton.classList.add("trix-active");
      this.editorToolbar.dataset.disableStylingInteraction = true;
    } else {
      this.editorToolbarCodeButton.classList.remove("trix-active");
      this.editorToolbar.removeAttribute("data-disable-styling-interaction");
    }
  }
  get editorToolbar() {
    return this.element.toolbarElement;
  }
  get editorToolbarCodeButton() {
    return this.editorToolbar.querySelector("[data-trix-attribute='code']");
  }
}
