import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello from refresh_controller!")
  }
  next(event) {
    console.log("what's next")

  }
}
