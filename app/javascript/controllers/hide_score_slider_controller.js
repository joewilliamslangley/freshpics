import { Controller } from "@hotwired/stimulus"


export default class extends Controller {
  static targets = [ "percentageQuestion", "numericQuestion" ]

  connect() {
    // console.log("The 'hide slider' controller is now loaded!")
  }

  toggleSlider(event) {
    if (event.currentTarget.value === "metacritic" || event.currentTarget.value === "imdb" || event.currentTarget.value === "rotten_tomatoes") {
      console.log("Metacritic/RT selected")
      this.percentageQuestionTarget.classList.remove("hidden");
      this.numericQuestionTarget.classList.add("hidden");
    }

    if (event.currentTarget.value === "imdb") {
      console.log("IMDB selected")
      this.numericQuestionTarget.classList.remove("hidden");
      this.percentageQuestionTarget.classList.add("hidden");

    }

    if (event.currentTarget.value === "no_site") {
      console.log("No site selected")
      this.numericQuestionTarget.classList.add("hidden");
      this.percentageQuestionTarget.classList.add("hidden");
    }
  }

}
