import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  connect() {
  }

  addQuantity(event) {
    const element = event.currentTarget
    const nextElement = element.nextElementSibling
    nextElement.classList.toggle("d-none")
  }
}
