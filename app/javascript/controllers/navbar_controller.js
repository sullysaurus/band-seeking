import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["burger", "menu"]

  connect() {
    console.log("NavbarController connected!")
    console.log("Burger target:", this.burgerTarget)
    console.log("Menu target:", this.menuTarget)
  }

  toggle(event) {
    console.log("Toggle clicked!", event)
    this.burgerTarget.classList.toggle("is-active")
    this.menuTarget.classList.toggle("is-active")
  }
} 