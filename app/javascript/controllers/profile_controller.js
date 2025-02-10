import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["bioContent"]

  editBio(event) {
    const content = this.bioContentTarget
    const currentText = content.textContent.trim()
    const textarea = document.createElement("textarea")
    textarea.className = "textarea"
    textarea.value = currentText
    content.replaceWith(textarea)
    textarea.focus()

    textarea.addEventListener("blur", () => {
      this.saveBio(textarea.value)
    })
  }

  async saveBio(text) {
    try {
      const response = await fetch("/musician", {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({ user: { bio: text } })
      })

      if (response.ok) {
        const div = document.createElement("div")
        div.className = "content editable-content"
        div.dataset.profileTarget = "bioContent"
        div.textContent = text
        document.querySelector("textarea").replaceWith(div)
      }
    } catch (error) {
      console.error("Error saving bio:", error)
    }
  }

  toggleAvailability(event) {
    event.preventDefault()
    const checkbox = event.target
    const form = checkbox.closest("form")
    form.requestSubmit()
  }

  // Add more methods for other editable sections...
} 