import { Controller } from "@hotwired/stimulus"
let num = 0;

export default class extends Controller {
  static targets = ["button", "question", "back", "forward"];

  nextQuestion(event) {
    event.preventDefault();

    this.questionTargets[num].classList.add("hidden");
    this.questionTargets[num + 1].classList.remove("hidden");
    this.questionTargets[num + 1].classList.add("fade-in");

    if (num == 0) this.backTarget.classList.remove("hidden");
    if (num == 2) this.forwardTarget.classList.add("hidden");

    num += 1;
  }

  previousQuestion(event) {
    event.preventDefault();

    this.questionTargets[num].classList.add("hidden");
    this.questionTargets[num - 1].classList.remove("hidden");
    this.questionTargets[num - 1].classList.add("fade-in");

    if (num == 1) this.backTarget.classList.add("hidden");
    if (num == 3) this.forwardTarget.classList.remove("hidden");

    num -= 1;
  }
}
