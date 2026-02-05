import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form"]

  submit(event) {
    // Si el evento viene de un radio button de price_range, actualizar los hidden fields
    if (event.target.name === 'price_range' && event.target.value) {
      const minPrice = event.target.dataset.minPrice
      const maxPrice = event.target.dataset.maxPrice

      if (minPrice && maxPrice) {
        const minPriceField = this.formTarget.querySelector('input[name="min_price"]')
        const maxPriceField = this.formTarget.querySelector('input[name="max_price"]')

        if (minPriceField) minPriceField.value = minPrice
        if (maxPriceField) maxPriceField.value = maxPrice
      }
    }

    // Si se deselecciona el price_range (selecciona "Todos"), limpiar los hidden fields
    if (event.target.name === 'price_range' && !event.target.value) {
      const minPriceField = this.formTarget.querySelector('input[name="min_price"]')
      const maxPriceField = this.formTarget.querySelector('input[name="max_price"]')

      if (minPriceField) minPriceField.value = ''
      if (maxPriceField) maxPriceField.value = ''
    }

    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 300)
  }

  reset() {
    this.formTarget.reset()
    this.formTarget.requestSubmit()
  }
}
