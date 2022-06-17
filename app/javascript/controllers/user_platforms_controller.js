import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["watchlist", "added", "ignore"]

  connect() {
    console.log("user_platforms")
  }

  change(event) {
    this.watchlistTarget.classList.add("d-none")
    this.addedTarget.classList.remove("d-none")
  }
}
