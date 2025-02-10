// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// Only import the controllers directory if you're actually using Stimulus
// import "./controllers"

console.log("Application.js loaded!")

// Debug Stimulus loading
document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM loaded!")
  const elements = document.querySelectorAll("[data-controller]")
  console.log("Elements with data-controller:", elements)
  
  elements.forEach(el => {
    console.log("Controller name:", el.dataset.controller)
  })
})