import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello from refresh_controller!")
  }
  next(event) {
    console.log(this.element.dataset.refreshMovies)
    let movieData = this.element.dataset.refreshMovies
    console.log(movieData)
    // fetch(`movies/${2}/result`)
    //     .then((res) => res.text())
    //     .then((html) => {
    //       const fragment = document
    //         .createRange()
    //         .createContextualFragment(html);
    //       console.log(fragment)
    //       this.element.appendChild(fragment);
    //       // OR document.getElementById("testy_element").appendChild(fragment)
    //     });
  }
}
