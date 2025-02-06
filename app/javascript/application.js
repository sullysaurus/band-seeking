// Configure your import map in config/importmap.rb
import "@hotwired/turbo-rails"
import "controllers"

// Add any custom JavaScript here 

// Add notification dismissal functionality
document.addEventListener('turbo:load', () => {
  // Handle notification dismissal
  const deleteButtons = document.querySelectorAll('.notification .delete');
  deleteButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const notification = button.closest('.notification');
      notification.remove();
    });
  });

  // Handle cropper modal
  const cropperModal = document.getElementById('cropperModal');
  const closeButtons = cropperModal.querySelectorAll('.delete, #cancelCrop');
  const cropButton = document.getElementById('cropButton');

  closeButtons.forEach(button => {
    button.addEventListener('click', () => {
      cropperModal.classList.remove('is-active');
    });
  });

  cropButton.addEventListener('click', () => {
    const event = new CustomEvent('crop', { bubbles: true });
    cropperModal.dispatchEvent(event);
  });
}); 