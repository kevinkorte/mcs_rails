$(document).ready(function(){
  // use this hash to cache search results
  window.query_cache = {};
  $('.typeahead').typeahead({
      source:function(query,process){
          // if in cache use cached value, if don't wanto use cache remove this if statement
          if(query_cache[query]){
              process(query_cache[query]);
              return;
          }
          if( typeof searching != "undefined") {
              clearTimeout(searching);
              process([]);
          }
          searching = setTimeout(function() {
              return $.getJSON(
                  "machines.json",
                  { q:query },
                  function(data){
                      // save result to cache, remove next line if you don't want to use cache
                      query_cache[query] = data;
                      // only search if stop typing for 300ms aka fast typers
                      return process(data);
                  }
              );
          }, 300); // 300 ms
      }
  });
});