import 'js-autocomplete/auto-complete.css';
import autocomplete from 'js-autocomplete';

let thing = document.querySelector(".container")

thing.colo

const autocompleteSearch = function() {

  const films = JSON.parse(document.getElementById('search-data').dataset.films)
  const searchInput = document.getElementById('q');

  if (films && searchInput) {
    new autocomplete({
      selector: searchInput,
      minChars: 1,
      source: function(term, suggest){
          term = term.toLowerCase();
          const choices = films;
          const matches = [];
          for (let i = 0; i < choices.length; i++)
              if (~choices[i].toLowerCase().indexOf(term)) matches.push(choices[i]);
          suggest(matches);
      },
    });
  }
};

export { autocompleteSearch };
