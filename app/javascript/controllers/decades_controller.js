import { Controller } from "@hotwired/stimulus"
const minimum = document.getElementById('decade_from');
const maximum = document.getElementById('decade_to');

export default class extends Controller {
  static targets = [ "minimum", "maximum" ]


  connect() {
    console.log("The 'decades' controller is now loaded!")
  }

  update(event) {
    console.log(minimum.value)

  }

}
