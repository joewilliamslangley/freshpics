import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "questionBlock", "imdb", "metacritic", "none" ]

  connect() {
    // console.log("The 'hide slider' controller is now loaded!")
  }

  hideSlider(event) {
    //this.questionTarget.classList.add("hidden");

    // hide the score slider by default / with no review selected

    // if the radio button selected is a critic site then show the slider
    // if label is IMDb or Metacritic or is not No Site

  }
}
