import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "modal", "image", "hiddenInput"]
  
  connect() {
    this.cropper = null
  }

  preview(event) {
    const file = event.target.files[0]
    if (file) {
      const reader = new FileReader()
      
      reader.onload = (e) => {
        const modal = document.getElementById('cropperModal')
        const image = document.getElementById('cropperImage')
        
        image.src = e.target.result
        
        // Initialize cropper
        if (this.cropper) {
          this.cropper.destroy()
        }
        
        this.cropper = new Cropper(image, {
          aspectRatio: 16 / 9,
          viewMode: 2,
          autoCropArea: 1,
        })
        
        modal.classList.add('is-active')
      }
      
      reader.readAsDataURL(file)
    }
  }

  crop() {
    if (this.cropper) {
      const canvas = this.cropper.getCroppedCanvas({
        width: 1600,
        height: 900
      })
      
      canvas.toBlob((blob) => {
        const file = new File([blob], 'cropped_image.jpg', { type: 'image/jpeg' })
        const container = new DataTransfer()
        container.items.add(file)
        
        const input = document.querySelector('input[type="file"]')
        input.files = container.files
        
        this.closeModal()
      }, 'image/jpeg')
    }
  }

  closeModal() {
    const modal = document.getElementById('cropperModal')
    modal.classList.remove('is-active')
    if (this.cropper) {
      this.cropper.destroy()
      this.cropper = null
    }
  }
} 