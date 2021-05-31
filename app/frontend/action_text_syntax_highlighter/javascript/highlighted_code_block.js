export class HighlightedCodeBlock extends HTMLElement {
  connectedCallback() {
    if (this.closest("trix-editor")?.editor) {
      this.setup()
    }
  }

  setup() {
    this.editor = this.closest("trix-editor").editor
    this.closest("figure").dataset.trixHighlightedCodeBlock = true

    this.trixId = parseInt(this.parentElement.dataset.trixId)
    this.attachment = this.editor.getDocument().getAttachmentById(this.trixId)
    this.attachment.type = "HighlightedCodeBlock"

    this.configureEventListeners()
  }

  save() {
    let sgid = this.attachment.getAttributes().sgid
    this.editor.syntaxHighlighter.saveCodeBlock(this.toJSON(), sgid)
    this.render()
  }

  render() {
    this.attachment.setAttributes({
      "content": this.outerHTML
    })
  }

  languageChanged(event) {
    this.selectLanguage(event.target.value)
    this.save()
  }

  selectLanguage(language) {
    this.languageSelector
      .querySelector("option[selected]")
      .removeAttribute("selected")

    this.languageSelector
      .querySelector(`option[value='${language}']`)
      .setAttribute("selected", "")
  }

  configureEventListeners() {
    this.codeBlock
      .addEventListener("blur", this.save.bind(this))
    this.languageSelector
      .addEventListener("change", this.languageChanged.bind(this))
  }

  toJSON() {
    return JSON.stringify({
      highlighted_code_block: {
        content: this.codeBlock.innerHTML,
        language: this.languageSelector.value
      }
    })
  }

  get codeBlock() {
    return this.querySelector("pre")
  }

  get languageSelector() {
    return this.querySelector("select")
  }
}