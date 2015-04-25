$(document).ready(function() { 
  var machines = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('title'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  limit: 10,
  prefetch: '/machines.json',
  remote: '/machines/queries/%QUERY.json',
  dupDetector: function(remoteMatch, localMatch) {
    return remoteMatch.value === localMatch.value;
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