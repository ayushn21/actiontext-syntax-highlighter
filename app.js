var __defProp = Object.defineProperty;
var __defNormalProp = (obj, key, value) => key in obj ? __defProp(obj, key, { enumerable: true, configurable: true, writable: true, value }) : obj[key] = value;
var __publicField = (obj, key, value) => {
  __defNormalProp(obj, typeof key !== "symbol" ? key + "" : key, value);
  return value;
};

// app/frontend/action_text_syntax_highlighter/javascript/highlighted_code_block.js
var HighlightedCodeBlock = class extends HTMLElement {
  connectedCallback() {
    var _a;
    if ((_a = this.closest("trix-editor")) == null ? void 0 : _a.editor) {
      this.setup();
    }
  }
  setup() {
    this.editor = this.closest("trix-editor").editor;
    this.closest("figure").dataset.trixHighlightedCodeBlock = true;
    this.trixId = parseInt(this.parentElement.dataset.trixId);
    this.attachment = this.editor.getDocument().getAttachmentById(this.trixId);
    this.attachment.type = "HighlightedCodeBlock";
    this.configureEventListeners();
  }
  save() {
    let sgid = this.attachment.getAttributes().sgid;
    this.editor.syntaxHighlighter.saveCodeBlock(this.toJSON(), sgid);
    this.render();
  }
  render() {
    this.attachment.setAttributes({
      "content": this.outerHTML
    });
  }
  languageChanged(event) {
    this.selectLanguage(event.target.value);
    this.save();
  }
  selectLanguage(language) {
    this.languageSelector.querySelector("option[selected]").removeAttribute("selected");
    this.languageSelector.querySelector(`option[value='${language}']`).setAttribute("selected", "");
  }
  configureEventListeners() {
    this.codeBlock.addEventListener("blur", this.save.bind(this));
    this.languageSelector.addEventListener("change", this.languageChanged.bind(this));
  }
  toJSON() {
    return JSON.stringify({
      highlighted_code_block: {
        content: this.codeBlock.innerHTML,
        language: this.languageSelector.value
      }
    });
  }
  get codeBlock() {
    return this.querySelector("pre");
  }
  get languageSelector() {
    return this.querySelector("select");
  }
};

// app/frontend/action_text_syntax_highlighter/javascript/helpers.js
function getDefaultHeaders() {
  return {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "X-CSRF-Token": getCsrfToken()
  };
}
function getCsrfToken() {
  return document.head.querySelector("meta[name='csrf-token']").content;
}

// app/frontend/action_text_syntax_highlighter/javascript/trix_code_block_highlighter.js
var TrixCodeBlockHighlighter = class {
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
      this.updateToolbarCodeButtonState(this.editor.getPosition());
    });
  }
  updateToolbarCodeButtonState(position) {
    var _a;
    let attachmentType = (_a = this.editor.getDocument().getPieceAtPosition(position).attachment) == null ? void 0 : _a.type;
    if (attachmentType == "HighlightedCodeBlock") {
      this.editorToolbarCodeButton.classList.add("trix-active");
    } else {
      this.editorToolbarCodeButton.classList.remove("trix-active");
    }
  }
  get editorToolbar() {
    return this.element.toolbarElement;
  }
  get editorToolbarCodeButton() {
    return this.editorToolbar.querySelector("[data-trix-attribute='code']");
  }
};

// app/frontend/action_text_syntax_highlighter/javascript/actiontext_syntax_highlighter.js
var ActionTextSyntaxHighlighter = class {
  static start() {
    customElements.define("highlighted-code-block", HighlightedCodeBlock);
    document.addEventListener("trix-initialize", (event) => {
      if (event.target.dataset.highlightsCodeBlocks) {
        new TrixCodeBlockHighlighter(event.target);
      }
    });
  }
};
__publicField(ActionTextSyntaxHighlighter, "basePath", "/rails/action_text/highlighted_code_blocks");
