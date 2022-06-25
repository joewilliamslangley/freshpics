import { Controller } from "@hotwired/stimulus"
const minimum = document.getElementById('decade_from');
const maximum = document.getElementById('decade_to');
const minimumOptions = ["1930", "1940", "1950", "1960", "1970", "1980", "1990", "2000", "2010", "2020"]
const maximumOptions = ["", "1939", "1949", "1959", "1969", "1979", "1989", "1999", "2009", "2019", "2029"]
function range(start, end) {
  return Array(end - start + 1).fill().map((_, idx) => start + idx)
}
function revealAll(select) {
  let all = range(1, 10)
  all.forEach((num) => {
    select.options[num].hidden = false
  });
}

function checkValid() {
  if (minimum.value > maximum.value){
    minimum.value = 'No Minimum'
  } else if (maximum.value < minimum.value){
    maximum.value = 'No Minimum'
  }
}

export default class extends Controller {
  static targets = [ "minimum", "maximum" ]


  connect() {
    console.log("The 'decades' controller is now loaded!")
  }

  minUpdate(event) {
    checkValid()
    revealAll(maximum)
    let selection = minimumOptions.indexOf(minimum.value)

    if(selection > 1 ){
      let remove = range(1, selection)
      remove.forEach((num) => {
        maximum.options[num].hidden = true
      });
    }
  }

  maxUpdate(event) {
    checkValid()
    revealAll(minimum)
    console.log(maximum.value)
    let selection = maximumOptions.indexOf(maximum.value)
    console.log(selection)
    if(selection > 0 ){
      let remove = range((selection + 1), 10)
      console.log(remove)
      remove.forEach((num) => {
        minimum.options[num].hidden = true
      });
    }
  }
}
