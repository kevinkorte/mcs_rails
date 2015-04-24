$(document).ready(function() { 
  var machines = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
  prefetch: {
    // url points to a json file that contains an array of country names, see
    // https://github.com/twitter/typeahead.js/blob/gh-pages/data/countries.json
    url: 'https://mcs-kevinkorte-5.c9.io/machines.json',
    // the json file contains an array of strings, but the Bloodhound
    // suggestion engine expects JavaScript objects so this converts all of
    // those strings
  }
});
 
// kicks off the loading/processing of `local` and `prefetch`
machines.initialize();
 
// passing in `null` for the `options` arguments will result in the default
// options being used
$('.typeahead').typeahead({
  highlight: true
}, {
  name: 'machines',
  displayKey: 'title',
  // `ttAdapter` wraps the suggestion engine in an adapter that
  // is compatible with the typeahead jQuery plugin
  source: machines.ttAdapter()
});

$('.typeahead').on('typeahead:selected', function(e, datum){
  console.log(datum.slug);
  window.location = '/machines/'+datum.slug
})

});