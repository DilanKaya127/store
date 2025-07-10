import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // File input preview functionality
    const fileInput = this.element.querySelector('.file-input')
    if (fileInput) {
      fileInput.addEventListener('change', function(e) {
        const file = e.target.files[0]
        const label = e.target.nextElementSibling
        if (file) {
          label.innerHTML = `
            <svg class="upload-icon" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
            </svg>
            ${file.name}
          `
          label.style.color = '#10b981'
          label.style.borderColor = '#10b981'
          label.style.backgroundColor = '#f0fdf4'
        }
      })
    }
    // Form submission with loading state
    const form = this.element.querySelector('form')
    if (form) {
      form.addEventListener('submit', function(e) {
        const submitBtn = form.querySelector('.submit-button')
        if (submitBtn) {
          submitBtn.classList.add('loading')
        }
      })
    }
  }
} 