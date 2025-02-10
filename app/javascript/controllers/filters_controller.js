import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content", "button", "icon"]

  connect() {
    console.log("Filters controller connected!")
    
    // Make controller globally accessible for debugging
    window.filtersController = this
    
    // Debug info
    console.log("Filters HTML:", this.element.outerHTML)
    console.log("Button exists?", !!this.element.querySelector('button'))
    console.log("Content exists?", !!this.element.querySelector('#filtersContent'))
  }

  toggle(event) {
    if (event) event.preventDefault()
    console.log("Toggle clicked!")
    
    const content = this.element.querySelector('#filtersContent')
    const button = this.element.querySelector('button')
    
    console.log({
      contentFound: !!content,
      buttonFound: !!button,
      currentClasses: content ? content.className : 'no content element'
    })
    
    if (content) {
      content.classList.toggle('is-hidden-mobile')
      console.log("New classes:", content.className)
    }
  }
} 