import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  greet() {
    console.log(`Hello, the element is:${this.buttonTarget.id}`)
  }
}
