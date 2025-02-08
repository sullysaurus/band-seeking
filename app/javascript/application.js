// Configure your import map in config/importmap.rb
import "@hotwired/turbo-rails"
import "controllers"

console.log("Application.js loaded!")

// Debug Stimulus loading
document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM loaded!")
  const elements = document.querySelectorAll("[data-controller]")
  console.log("Elements with data-controller:", elements)
})