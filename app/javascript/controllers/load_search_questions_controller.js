import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  load(event) {
    const id = this.element.id;
    const idNumber = parseInt(id.substr(id.length - 1));

    event.preventDefault();
    this.element.classList.add("hidden");

    const nextQuestion = document.getElementById(`question-${idNumber + 1}`);
    nextQuestion.classList.remove("hidden");
    nextQuestion.classList.add("fade-in");
  }
}
