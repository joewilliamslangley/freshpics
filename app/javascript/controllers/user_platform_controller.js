import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("user_platforms")
  }

  change(event) {
    console.log(this.element)
    this.element.classList.toggle("user-platform-unselected")
    // console.log("clicked")
  }
}
