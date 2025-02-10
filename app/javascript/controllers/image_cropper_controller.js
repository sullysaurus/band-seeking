import { Controller } from "@hotwired/stimulus"
import Cropper from 'cropperjs'
import 'cropperjs/dist/cropper.css'

export default class extends Controller {
  static targets = ["input", "preview", "filename", "modal", "cropperImage"]

  connect() {
    console.log("Image Cropper Connected")
    this.cropper = null
  }

  imageSelected() {
    const file = this.inputTarget.files[0]
    if (!file) return

    if (this.hasFilenameTarget) {
      this.filenameTarget.textContent = file.name
    }

    const reader = new FileReader()
    reader.onload = (e) => {
      this.cropperImageTarget.src = e.target.result
      this.openModal()
    }
    reader.readAsDataURL(file)
  }

  openModal() {
    this.modalTarget.classList.add('is-active')
    document.documentElement.classList.add('is-clipped')
    setTimeout(() => this.initializeCropper(), 100)
  }

  closeModal() {
    this.modalTarget.classList.remove('is-active')
    document.documentElement.classList.remove('is-clipped')
    if (this.cropper) {
      this.cropper.destroy()
      this.cropper = null
    }
  }

  initializeCropper() {
    if (this.cropper) {
      this.cropper.destroy()
    }

    this.cropper = new Cropper(this.cropperImageTarget, {
      aspectRatio: 16 / 9,
      viewMode: 1,
      dragMode: 'move',
      autoCropArea: 0.8,
      responsive: true,
      restore: false,
      guides: true,
      center: true,
      highlight: false,
      cropBoxMovable: true,
      cropBoxResizable: true,
      toggleDragModeOnDblclick: false,
      ready: () => {
        console.log("Cropper ready")
      }
    })
  }

  crop() {
    console.log("Crop button clicked")
    if (!this.cropper) {
      console.error("No cropper instance")
      return
    }

    this.cropper.getCroppedCanvas({
      width: 1600,
      height: 900,
      imageSmoothingEnabled: true,
      imageSmoothingQuality: 'high',
    }).toBlob((blob) => {
      const file = new File([blob], 'cropped-image.jpg', { type: 'image/jpeg' })
      const dataTransfer = new DataTransfer()
      dataTransfer.items.add(file)
      
      this.inputTarget.files = dataTransfer.files
      
      if (this.hasPreviewTarget) {
        const previewUrl = URL.createObjectURL(blob)
        this.previewTarget.src = previewUrl
        this.previewTarget.style.display = 'block'
      }
      
      this.closeModal()
    }, 'image/jpeg', 0.9)
  }
} 