import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const cards = this.element.querySelectorAll("[data-hover-card]")
    cards.forEach(card => {
      card.addEventListener("mouseenter", () => {
        card.style.transform = "translateY(-5px)"
        card.style.transition = "transform 0.2s ease"
      })
      card.addEventListener("mouseleave", () => {
        card.style.transform = "translateY(0)"
      })
    })
  }
}
