import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("The 'range slider value' controller is now loaded!")
  }
}
