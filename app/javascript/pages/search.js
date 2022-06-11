let number = 1;
let question = `question-${number}`;
let btn = document.getElementById(`btn-${number}`);
const addEventListenerToButtons = ((btn) => {
  btn.addEventListener('click', (event) => {
    number += 1;
    if (number < 5) {
      event.preventDefault();
      nextDiv = document.getElementById(`question-${number}`);
      console.log(nextDiv);
      btn = document.getElementById(`btn-${number}`);
      addEventListenerToButtons(btn);
    }
  });
});

if (btn) {
  addEventListenerToButtons(btn);
}
