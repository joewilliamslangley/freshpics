import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["card", "expand"]

  connect() {
    // console.log("hello from search_result_controller!")
  }

  revealContent() {
    this.expandTarget.classList.toggle("d-none")
    this.cardTarget.classList.toggle("result-card single")
  }
}
