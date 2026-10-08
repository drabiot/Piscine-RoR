import $ from "jquery"

$(document).on('turbo:load', function () {
  const $box = $('#entries')
  if ($box.length === 0) return

  $.getJSON($box.data('url'), function (entries) {
    $box.empty()
    $.each(entries, function (_, entry) {
      $('<p>', { class: 'entry border-bottom py-2' }).text(entry).appendTo($box)
    })
  })
})