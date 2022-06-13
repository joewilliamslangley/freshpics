import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "added"]

  connect() {
    console.log("hello from refresh_controller!")
  }

  change(event) {
    console.log(this.buttonTarget.innerText)
    console.log(this.buttonTarget.innerText)
    this.buttonTarget.classList.add("d-none")
    this.addedTarget.classList.remove("d-none")
  }
}
