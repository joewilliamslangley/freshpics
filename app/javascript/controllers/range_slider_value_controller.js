import { Controller } from "@hotwired/stimulus"

// const slider = document.getElementById("scoreRange");
// const output = document.getElementById("value-output");


export default class extends Controller {
  static targets = [ "platform", "valueOutput", "scoreRange", "numericOutput", "percentageOutput","percentageScoreRange", "numericScoreRange", "site"]

  connect() {
    // console.log("The 'range slider value' controller is now loaded!")
  }

  showScore(event) {
    let platform = document.querySelector('input[class="critic-tag-selector"]:checked').value;
  if (platform === "rotten_tomatoes" || platform === "metacritic")  {
      this.percentageOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value}%`
  }
  if (platform === "imdb") {
    this.percentageOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value / 10}`
}

    }

    showScoreFilter(event) {
      let input = document.querySelectorAll('#review_site')[1];
      let platform = input.options[input.selectedIndex].value;
      console.log(platform)
    if (platform === "rotten_tomatoes" || platform === "metacritic")  {
        this.percentageOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value}%`
    }
    if (platform === "imdb") {
      this.percentageOutputTarget.innerHTML = `${this.percentageScoreRangeTarget.value / 10}`
  }

      }

  showTime(event) {
      if (this.scoreRangeTarget.value > 179) {
      this.valueOutputTarget.innerHTML = "No limit";
    } else {
      this.valueOutputTarget.innerHTML = `${this.scoreRangeTarget.value} mins`
    }
    // Update the current slider value (each time you drag the slider handle)
    // this.valueOutputTarget.innerHTML = this.scoreRangeTarget.value

    }

}
