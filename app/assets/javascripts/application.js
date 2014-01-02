// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require cocoon

var ready;
ready = function(){
	
	$('input.create-purchase').click(function(){
		if($('#purchase_vendor_id :selected').text() == "Please select"){
			alert("Please select vendor and Products");
			return false;
		}
		return true;
	});

	$('#distributor_location_id').change(function(){
		if(this.value.length > 0){
			$.ajax({
				url:"/locations/"+this.value+"/distributors",
					async: true,
        			dataType: 'script'
			});

		}
		else{
			alert("Please select any Location");
		}
	});	

	var distributors = $('#sale_distributor_id').html();
	$('#sale_distributor_id').parents().find('.sub-div').hide();	
	$('.sales-div-actions').hide();	
	$(".new-distributor-div").empty();	
	$('#sale_location_id').change(function(){
	$(".new-distributor-div").empty();
		// var location = $("#sale_location_id option:selected").text()
		var location = $(this).find(":selected").text()
		console.log(location,"new location");
		var options = $(distributors).filter("optgroup[label='"+location+"']").html();
		console.log(options,"options");
		if(options){
			$('#sale_distributor_id').html(options);
			$('#sale_distributor_id').parents().find('.sub-div').show();	
			$('.sales-div-actions').show();
		}
		else{
			var link = "<h4>No any Distributor for "+location+"</h4><a href='/locations/"+ this.value+"/distributors/new' class='btn btn-mini btn-danger'>Add New Distributor</a>"
			$(".new-distributor-div").append(link);			
			$('#sale_distributor_id').empty();
			$('#sale_distributor_id').parents().find('.sub-div').hide();	
			$('.sales-div-actions').hide();	
		}
	});


	$('.new-purchase-div').on("cocoon:before-remove", function() {
        console.log("hey before remove");
      })
      .on("cocoon:after-remove", function() {
        console.log("after remove");
      });


};

$(document).ready(ready);
$(document).on('page:load', ready);

