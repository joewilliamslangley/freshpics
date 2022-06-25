import { Controller } from "@hotwired/stimulus"

// const slider = document.getElementById("scoreRange");
// const output = document.getElementById("value-output");


export default class extends Controller {
  static targets = [ "numericOutput", "percentageOutput","percentageScoreRange", "numericScoreRange" ]

  connect() {
    // console.log("The 'range slider value' controller is now loaded!")
  }

  showScore(event) {
  if (event.currentTarget === this.percentageScoreRangeTarget) {
      this.percentageOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value}%`
  }

  if (event.currentTarget === this.numericScoreRangeTarget) {
    this.numericOutputTarget.innerHTML = `${this.numericScoreRangeTarget.value}`
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

    }

}
