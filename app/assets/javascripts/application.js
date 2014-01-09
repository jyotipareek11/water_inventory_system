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
//= require jquery.ui.all

var ready;
ready = function(){

	$('.datepicker').datepicker();

	$('input.create-purchase').click(function(){
		if($('#purchase_vendor_id :selected').text() == "Please select"){
			alert("Please select vendor and Products");
			return false;
		}
		return true;
	});

	$('input.from-distributor').click(function(){
		if($('#sale_client_id :selected').text() == "Please select"){
			alert("Please select Client and Products");
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
	// event for location change in sale
	$('#sale_location_id').change(function(){
		$(".new-distributor-div").empty();
		if(this.value.length == 0){
			$('.sub-div').hide();
			$('.sales-div-actions').hide();	
			alert("Please select any Location");
		}else{

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
		}	
	
	});

	// $('.sales-product-select').change(function(){
	$(document).on('change', '.sales-product-select', function(){		
		var ele = $(this).parents('.product-control').find('.avail-unit');
		console.log(ele,"ele");
		var availEle = $(this).parent().parent().next().find('.avail-no-of-units');
		ele.html("");
		ele.attr("rel",0);
		availEle.attr("rel",0);
		if(this.value.length > 0){
	     	jQuery.getJSON("/products/"+$(this).val()+"/available_quantity_in_inventory",function(data){
          		console.log(data);
          		ele.html("Available Units In Stock: "+data);
          		ele.attr("rel",data);
          		availEle.attr("rel",data);
			})
		}
		else{
			ele.html("");
			ele.attr("rel",0);
			availEle.attr("rel",0);
			alert("Please select any Product");	
		}			
	});

	// $(document).on('click','.create-sale-button',function(){
	// 	var readyForSubmit = true
	// 	var errorUl = $('.sales-error-div').find('ul');
	// 	errorUl.empty();
	// 	// validation for product 
	// 	if($('.sales-product-select').val().length <= 0){
	// 		$(errorUl).append('<li>Please Select Product from Product List</li>');
	// 		readyForSubmit = false	
	// 	}
	// 	// validation for no of unit to be more then 0 and less or equall to available units in stock
	// 	if(parseInt($('.sale-no-of-unit').val()) <= 0){
	// 		$(errorUl).append('<li>Please enter No of Unit</li>');
	// 		readyForSubmit = false	
	// 	}
	// 	else{
	// 		require_unit = parseInt($('.sale-no-of-unit').val());
	// 		avail_unit = parseInt($('.sale-no-of-unit').next('.avail-no-of-units').attr('rel'));
	// 		if(require_unit > avail_unit){
	// 			console.log("inside error");
	// 			$(errorUl).append('<li>No of Unit should be less then or equal to available unit in sock</li>');
	// 			readyForSubmit = false	
	// 		}
	// 	}
	// 	// validation for unit price
	// 	if(parseInt($('.sale-unit-price').val()) <= 0){
	// 		$(errorUl).append('<li>Please Enter Unit Price</li>');
	// 		readyForSubmit = false	
	// 	}
	// 	console.log(readyForSubmit,"readyForSubmit");
	// 	if(readyForSubmit){
	// 		return true;
	// 	}
	// 	else{
	// 		$('.sales-error-div').show();
	// 		return false;
	// 	}

		
	// })


	 // $(".input-only-numbers").keydown(function (event) {
	 $(document).on('keydown','.input-only-numbers',function(event){

        if (event.shiftKey == true) {
            event.preventDefault();
        }

        if ((event.keyCode >= 48 && event.keyCode <= 57) || 
            (event.keyCode >= 96 && event.keyCode <= 105) || 
            event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 37 ||
            event.keyCode == 39 || event.keyCode == 46 || event.keyCode == 190) {

        } else {
            event.preventDefault();
        }

        if($(this).val().indexOf('.') !== -1 && event.keyCode == 190)
            event.preventDefault(); 
        //if a decimal has been added, disable the "."-button

    });

// setting total price and price after discount based on no_of_units,unit_price and discount for purchase

	 $(document).on('change','.purchase-unit-price',function(){
	 	var ele = $(this),
	 	 	unit_price = parseInt(ele.val()),
	 	 	no_of_Unit = parseInt(ele.parent().parent().prev().find('.purchase-no-of-unit').val());
	 	ele.parent().parent().next().find('.purchase-total-price').val(unit_price*no_of_Unit);
	 });

	 $(document).on('change','.purchase-discount',function(){
	 	var ele = $(this), 
	 		discount = parseInt(ele.val()),
	 		total_price = parseInt(ele.parent().parent().prev().find('.purchase-total-price').val());
	 	ele.parent().parent().next().find('.purchase-price-after-discount').val(total_price-discount);
	 });
// setting total price and price after discount based on no_of_units,unit_price and discount for sale
	 $(document).on('change','.sale-unit-price',function(){
	 	var ele = $(this),
	 	 	unit_price = parseInt(ele.val()),
	 	  	no_of_Unit = parseInt(ele.parent().parent().prev().find('.sale-no-of-unit').val());
	 	ele.parent().parent().next().find('.sale-total-price').val(unit_price*no_of_Unit);
	 });

	 $(document).on('change','.sale-discount',function(){
	 	var ele = $(this),
	 		discount = parseInt(ele.val()),
	 		total_price = parseInt(ele.parent().parent().prev().find('.sale-total-price').val());
		ele.parent().parent().next().find('.sale-price-after-discount').val(total_price-discount);
	 });

};

$(document).ready(ready);
$(document).on('page:load', ready);

