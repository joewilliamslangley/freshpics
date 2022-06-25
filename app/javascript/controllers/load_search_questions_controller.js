import { Controller } from "@hotwired/stimulus"
let num = 0;

export default class extends Controller {
  static targets = ["button", "question", "back", "forward", "circle", "progress"];

 connect() {
   num = 0;
  }

  handleLoading(event, addNum) {
    event.preventDefault();
    this.questionTargets[num].classList.add("hidden");
    this.questionTargets[num + addNum].classList.remove("hidden");
    this.questionTargets[num + addNum].classList.add("fade-in");
    num += addNum;
  }

  nextQuestion(event) {
    console.log(num)
    this.handleLoading(event, 1)

    if (num == 1) this.backTarget.classList.remove("hidden");
    if (num == 3) this.forwardTarget.classList.add("hidden");
    this.circleTargets[num].classList.add("active");
    this.progressTarget.style.width = (num / 3) * 100 + "%";
  }

  previousQuestion(event) {
    this.handleLoading(event, -1)

    if (num == 0) this.backTarget.classList.add("hidden");
    if (num == 2) this.forwardTarget.classList.remove("hidden");
    this.circleTargets[num + 1].classList.remove("active");
    this.progressTarget.style.width = (num / 3) * 100 + "%";
  }
}
