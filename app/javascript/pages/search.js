let number = 1;
let question = `question-${number}`;
let btn = document.getElementById(`btn-${number}`);

const addEventListenerToButtons = ((btn) => {
  btn.addEventListener('click', (event) => {
    number += 1;
    if (number < 5) {
      event.preventDefault();
      currentDiv = document.getElementById(`question-${number - 1}`);
      currentDiv.classList.add("hidden")
      nextDiv = document.getElementById(`question-${number}`);
      nextDiv.classList.remove("hidden")
      nextDiv.classList.add("fade-in")
      btn = document.getElementById(`btn-${number}`);
      addEventListenerToButtons(btn);
      alert("button pressed")
    }
  });
});

if (btn) {
  addEventListenerToButtons(btn);
}
