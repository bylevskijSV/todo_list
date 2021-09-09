function select_check() {
  $('#assigned_checkbox').on('click',function () {
    if ($(this).is(':checked')) {
      $("#assigned_select").css({"display":"block"});
    } else {
      $("#assigned_select").css({"display":"none"});
    }
  });
}

$(document).on('turbolinks:load', function() {

  select_check()

});

