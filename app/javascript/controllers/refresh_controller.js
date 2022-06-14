import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("hello from refresh_controller!")
  }
  next(event) {
    const allMovies = this.element.dataset.results
    const newMovies = allMovies.splice(0,3)

  }
}
