$('document').ready(function() {
  $('#awarded')
})

$(document).on('click', '#awarded', function (event) {
  $(".entry-no-award").toggle(!this.checked);
});
