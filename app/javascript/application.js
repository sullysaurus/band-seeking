// Configure your import map in config/importmap.rb
import "@hotwired/turbo-rails"
import "controllers"

function initializeFilters() {
  const filterToggle = document.querySelector('[data-action="toggle-filters"]');
  if (filterToggle) {
    filterToggle.addEventListener('click', () => {
      const filtersContent = document.getElementById('filtersContent');
      const toggleText = filterToggle.querySelector('span:not(.icon)');
      const toggleIcon = filterToggle.querySelector('.fa-chevron-down');
      
      if (filtersContent.classList.contains('is-hidden-mobile')) {
        filtersContent.classList.remove('is-hidden-mobile');
        toggleText.textContent = 'Hide Filters';
        toggleIcon.style.transform = 'rotate(180deg)';
      } else {
        filtersContent.classList.add('is-hidden-mobile');
        toggleText.textContent = 'Show Filters';
        toggleIcon.style.transform = 'rotate(0)';
      }
    });
  }
}

function initializeNavbar() {
  const navbarBurger = document.querySelector('.navbar-burger');
  const navbarMenu = document.querySelector('.navbar-menu');

  if (navbarBurger) {
    navbarBurger.addEventListener('click', () => {
      navbarBurger.classList.toggle('is-active');
      navbarMenu.classList.toggle('is-active');
    });
  }
}

function initializeNotifications() {
  const deleteButtons = document.querySelectorAll('.notification .delete');
  deleteButtons.forEach((button) => {
    button.addEventListener('click', () => {
      const notification = button.closest('.notification');
      notification.remove();
    });
  });
}

// Initialize on both DOMContentLoaded and turbo:load
document.addEventListener('DOMContentLoaded', () => {
  initializeFilters();
  initializeNavbar();
  initializeNotifications();
});

document.addEventListener('turbo:load', () => {
  initializeFilters();
  initializeNavbar();
  initializeNotifications();

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