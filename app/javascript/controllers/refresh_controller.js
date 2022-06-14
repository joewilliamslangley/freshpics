import { Controller } from "@hotwired/stimulus"
const cards = document.querySelectorAll(".result-card");
let cards_array = cards_array = [...cards];
let current_cards = cards_array.splice(0,3)
current_cards.forEach((card) => card.style.display = 'block')

export default class extends Controller {
  connect() {
    // console.log("Howdy")

  }
  next(event) {
    current_cards.forEach((card) => card.style.display = 'none')
    current_cards = cards_array.splice(0,3)
    current_cards.forEach((card) => card.style.display = 'block')
    window.scrollTo(0,0)
    // ('html, body').animate({ scrollTop: 0 }, 'fast');
    // let movieData = this.element.dataset.refreshMovies
    // console.log(movieData)
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
