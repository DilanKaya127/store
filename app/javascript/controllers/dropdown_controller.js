import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.toggleHandler = this.toggle.bind(this)
    this.closeHandler = this.close.bind(this)
    this.element.querySelector(".dropdown-toggle").addEventListener("click", this.toggleHandler)
    document.addEventListener("click", this.closeHandler)
  }

  disconnect() {
    this.element.querySelector(".dropdown-toggle").removeEventListener("click", this.toggleHandler)
    document.removeEventListener("click", this.closeHandler)
  }

  toggle(event) {
    event.stopPropagation()
    this.element.classList.toggle("open")
  }

  close(event) {
    if (!this.element.contains(event.target)) {
      this.element.classList.remove("open")
    }
  }
} 