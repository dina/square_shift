/**
 * Created by yunus on 4/17/14.
 */

$(document).ready(function() {
    $('select.user-shift').change(function() {
        if (schedule_published) {
            alert("You cannot change a published schedule! YET!");
        }
    });

    $('.publish-schedule-btn').click(function(){
        var user_shift_ids = $.map($('select.user-shift'), function(elt) {return parseInt($(elt).val());});
        $.ajax({
            url: "/admin/shifts/publish_schedule",
            type: "POST",
            data: {
                user_shift_ids: user_shift_ids
            }
        }).done(function() {
            $('.calendar-buttons').fadeOut();
            $('.publish-schedule-modal, .modal-backdrop').fadeIn();
            schedule_published = true;
        });
    });

});
