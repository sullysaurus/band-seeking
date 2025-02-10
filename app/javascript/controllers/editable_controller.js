import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  edit(event) {
    const field = event.currentTarget.dataset.editableField
    const type = event.currentTarget.dataset.editableType
    const content = this.contentTarget
    const currentValue = content.textContent.trim()

    let input
    if (type === "textarea") {
      input = document.createElement("textarea")
      input.className = "textarea"
    } else {
      input = document.createElement("input")
      input.className = "input"
      input.type = type || "text"
    }

    input.value = currentValue === content.querySelector(".placeholder")?.textContent ? "" : currentValue
    content.replaceWith(input)
    input.focus()

    input.addEventListener("blur", () => {
      this.save(field, input.value)
    })

    input.addEventListener("keydown", (e) => {
      if (e.key === "Enter" && type !== "textarea") {
        input.blur()
      }
    })
  }

  async save(field, value) {
    const userId = window.location.pathname.split('/').pop()
    try {
      const response = await fetch(`/musicians/${userId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
        },
        body: JSON.stringify({
          user: {
            [field]: value
          }
        })
      })

      if (response.ok) {
        const div = document.createElement("div")
        div.className = "field-content"
        div.dataset.editableTarget = "content"
        div.textContent = value || this.element.querySelector(".placeholder").textContent
        document.querySelector(`[data-editable-field="${field}"]`).parentElement.replaceChild(div, document.querySelector("input, textarea"))
      }
    } catch (error) {
      console.error("Error saving:", error)
    }
  }
} 