import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "icon"]

  connect() {
    // Start collapsed
    this.collapse()
  }

  toggle() {
    if (this.content.classList.contains("is-collapsed")) {
      this.expand()
    } else {
      this.collapse()
    }
  }

  collapse() {
    this.content.classList.add("is-collapsed")
    this.icon.classList.remove("is-rotated")
    this.content.style.maxHeight = "0"
  }

  expand() {
    this.content.classList.remove("is-collapsed")
    this.icon.classList.add("is-rotated")
    this.content.style.maxHeight = `${this.content.scrollHeight}px`
  }

  get content() {
    return this.contentTarget
  }

  get icon() {
    return this.iconTarget
  }
} 