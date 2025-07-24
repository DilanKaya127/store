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
      // Tıklama yönlendirmesi
      card.addEventListener("click", (event) => {
        const isButtonClick = event.target.closest("form, button, a")
        if (isButtonClick) return // Sepete ekle vs gibi alanlara tıklanıyorsa yönlendirme yapma

        const url = card.dataset.url
        if (url) window.location.href = url
      })
    })
  }
}
