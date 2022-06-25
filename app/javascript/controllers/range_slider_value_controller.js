import { Controller } from "@hotwired/stimulus"

// const slider = document.getElementById("scoreRange");
// const output = document.getElementById("value-output");


export default class extends Controller {
  static targets = [ "valueOutput", "percentageScoreRange", "numericScoreRange" ]

  connect() {
    // console.log("The 'range slider value' controller is now loaded!")
  }

  showScore(event) {
  if (event.currentTarget === this.percentageScoreRangeTarget) {
      this.valueOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value}%`
  }

  if (event.currentTarget === this.numericScoreRangeTarget) {
    this.valueOutputTarget.innerHTML = `${this.numericScoreRangeTarget.value}%`
}

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
