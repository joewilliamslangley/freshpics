import { Controller } from "@hotwired/stimulus"

const slider = document.getElementById("scoreRange");
const output = document.getElementById("value-output");


export default class extends Controller {
  static targets = [ "valueOutput", "scoreRange" ]

  connect() {
    // console.log("The 'range slider value' controller is now loaded!")
  }

  showScore(event) {
    // console.log(event)
    this.valueOutputTarget.innerHTML = `${this.scoreRangeTarget.value}%`

    // JAVASCRIPT CODE
    // output.innerHTML = slider.value; // Display the default slider value

    // // Update the current slider value (each time you drag the slider handle)
    // slider.oninput = function() {
    //   output.innerHTML = this.value;
    }

  showTime(event) {
    // console.log(event)
    if (this.scoreRangeTarget.value > 179) {
      this.valueOutputTarget.innerHTML = "No limit";
    } else {
      this.valueOutputTarget.innerHTML = `${this.scoreRangeTarget.value} mins`
    }
    // Update the current slider value (each time you drag the slider handle)
    // this.valueOutputTarget.innerHTML = this.scoreRangeTarget.value

    // JAVASCRIPT CODE
    // output.innerHTML = slider.value; // Display the default slider value

    // // Update the current slider value (each time you drag the slider handle)
    // slider.oninput = function() {
    //   output.innerHTML = this.value;
    }

}
