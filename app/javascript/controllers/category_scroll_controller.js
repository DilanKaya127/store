import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const section = this.element
    const cards = section.querySelectorAll(".category-card")
    cards.forEach(card => {
      const clone = card.cloneNode(true)
      clone.classList.add("cloned")
      section.appendChild(clone)
    })

    this.scrollAmount = 0
    this.isPaused = false

    this.autoScroll = this.autoScroll.bind(this)
    this.autoScroll()

    section.addEventListener("mouseover", () => { this.isPaused = true })
    section.addEventListener("mouseout", () => { this.isPaused = false })
  }

  autoScroll() {
    if (!this.isPaused) {
      this.scrollAmount += 0.5
      this.element.scrollLeft = this.scrollAmount
      if (this.scrollAmount >= this.element.scrollWidth / 2) {
        this.scrollAmount = 0
      }
    }
    requestAnimationFrame(this.autoScroll)
  }
} 