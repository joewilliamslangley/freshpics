import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "question" ]

  connect() {
    // console.log("The 'hide slider' controller is now loaded!")
  }

  toggleSlider(event) {
    if (event.currentTarget.value === "metacritic" || event.currentTarget.value === "imdb") {
      this.questionTarget.classList.remove("hidden");
      // console.log(this.questionTarget)
    }

    if (event.currentTarget.value === "no_site") {
      this.questionTarget.classList.add("hidden");
      // console.log(this.questionTarget)
    }
  }

}
