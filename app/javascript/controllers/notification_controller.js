import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Notification controller connected!")

    // Optional: auto-dismiss after 5 seconds
    // setTimeout(() => {
    //   this.dismiss()
    // }, 5000)

    // Add click event listener to any delete button within the notification
    const deleteButton = this.element.querySelector('.delete')
    if (deleteButton) {
      deleteButton.addEventListener('click', () => this.dismiss())
    }
  }

  dismiss() {
    console.log("Dismiss called!")
    this.element.remove()
  }
} 