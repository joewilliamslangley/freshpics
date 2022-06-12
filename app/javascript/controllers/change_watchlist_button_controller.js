import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log("hello from refresh_controller!")
  }

  add(event) {
    console.log('added')
  }
}
