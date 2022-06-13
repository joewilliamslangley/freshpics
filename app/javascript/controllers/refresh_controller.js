import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello from refresh_controller!")
  }
  next(event) {
    console.log(this.element.dataset.refreshMovies)
    console.log("what's next")
    fetch("views/movies/_test.html.erb")
        .then((res) => res.text())
        .then((html) => {
          const fragment = document
            .createRange()
            .createContextualFragment(html);

          this.element.appendChild(fragment);
          // OR document.getElementById("testy_element").appendChild(fragment)
        });
  }
}
