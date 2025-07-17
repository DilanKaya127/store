import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["searchInput", "searchIcon"]

  connect() {
    this.listenForEnter()
  }

  listenForEnter() {
    if (this.hasSearchInputTarget) {
      this.searchInputTarget.addEventListener("keydown", (event) => {
        if (event.key === "Enter") {
          event.preventDefault() // isteğe bağlı
          this.searchInputTarget.closest("form").submit()
        }
      })
    }
  }

  submitSearch() {
    if (this.hasSearchInputTarget && this.searchInputTarget.value.trim() !== "") {
      this.searchInputTarget.closest("form").submit()
    }
  }
  
}
