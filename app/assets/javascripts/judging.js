$(document).on('click', '.Judging-check', function (event) {
    $('.' + $(this).attr('data-check')).toggle(this.checked);
});
