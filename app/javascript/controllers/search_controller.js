import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const form = this.inputTarget.closest("form")
      form.requestSubmit()
    }, 500)
  }
}
