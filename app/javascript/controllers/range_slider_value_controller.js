import { Controller } from "@hotwired/stimulus"

const slider = document.getElementById("scoreRange");
const output = document.getElementById("value-output");


export default class extends Controller {
  static targets = [ "valueOutput", "scoreRange" ]

  connect() {
    // console.log("The 'range slider value' controller is now loaded!")
  }

  showValue(event) {
    console.log(event)
    this.valueOutputTarget.innerHTML = "Number"
    // output.innerHTML = slider.value;
    // slider.oninput = function() {
    // output.innerHTML = this.value;
  }


}
