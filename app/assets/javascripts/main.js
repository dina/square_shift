var ready = function() {
  $('.availability-calendar').children('.calendar-shift').click(function(){
    var shiftId = parseInt($(this).attr('data-id'));
    if (activeShiftsArray.indexOf(shiftId) > -1) {
      itemIndex = activeShiftsArray.indexOf(shiftId);
      activeShiftsArray.splice(itemIndex, 1);
    } else {
      activeShiftsArray.push(shiftId);
    };
    $('.current-user-shifts').html(activeShiftsArray.toString());
    $(this).toggleClass('active');
  });

  $('.update-shifts-btn').click(function(){
    $.ajax({
      url: "/user_shifts/update_selections",
      type: "POST",
      data: {
        shift_ids: activeShiftsArray
      }
    }).done(function() {
      $('.notification-modal, .modal-backdrop').fadeIn();
    });
  });

  $('.modal-backdrop, .modal-close-button').click(function(){
    $('.modal-backdrop, .modal').fadeOut();
  });
};



$(document).ready(ready);
$(document).on('page:load', ready);
