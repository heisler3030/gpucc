function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
  $('.input-daterange').datepicker({format: 'yyyy-mm-dd',todayBtn: true});
}

$(function() {
	$('.input-daterange') //.onfocus({
		.datepicker({
    		format: 'yyyy-mm-dd',
    		todayBtn: true
    	});
//	});
});


// Javascript to enable link to tab
$(document).ready(function(event) {
    $('ul.nav.nav-tabs a:first').tab('show'); // Select first tab
    $('ul.nav.nav-tabs a[href="'+ window.location.hash+ '"]').tab('show'); // Select tab by name if provided in location hash
    $('ul.nav.nav-tabs a[data-toggle="tab"]').on('shown', function (event) {    // Update the location hash to current tab
        window.location.hash= event.target.hash;
    })
});