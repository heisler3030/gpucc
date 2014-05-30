// Nested Forms Utilities
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(id, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $("#" + id).append(content.replace(regexp, new_id));

}

// Date Picker Initialization
$(function() {
	$('.input-daterange')
		.datepicker({
    		format: 'yyyy-mm-dd',
    		todayHighlight: true,
        todayBtn: "linked"
    	});
});

// Enable Bootstrap Tabcollapse
$('#myTab').tabCollapse();

// Javascript to enable href to specific tab
$(document).ready(function(event) {
    $('ul.nav.nav-tabs a:first').tab('show'); // Select first tab
    $('ul.nav.nav-tabs a[href="'+ window.location.hash+ '"]').tab('show'); // Select tab by name if provided in location hash
    $('ul.nav.nav-tabs a[data-toggle="tab"]').on('shown', function (event) {    // Update the location hash to current tab
        window.location.hash= event.target.hash;
    })
});

// Show invite request form on login page
function requestInvite() {
  $('#myModal').modal('show');
}
function editCompletedSet(cs_id) {
  // Fetch JS to populate modal
  var completedSetJS = "/completed_sets/" + cs_id + "/edit";
  $.get(completedSetJS, null, null, "script");
};

function createExclusion(user, workout) {
  // Fetch JS to populate modal
  var completedSetJS = "/completed_workouts/new";
  $.get(completedSetJS, {user: user, workout: workout}, null, "script");
};


$(function() {
  // Create a countdown timer till midnight for DIV with id #countdown
  var currentDate = new Date();
  var tomorrow = new Date(currentDate.getFullYear(), currentDate.getMonth(), currentDate.getDate() + 1)
  $('#countdown').countdown({until: tomorrow});
});