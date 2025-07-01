// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

document.addEventListener("turbo:load", () => {
  const notice = document.getElementById("notice");
  if (notice) {
    setTimeout(() => {
      notice.classList.add("fade-out");
      setTimeout(() => {
        notice.remove(); // tamamen kaldırmak için
      }, 500); // Geçiş süresi
    }, 3000);
  }
});
