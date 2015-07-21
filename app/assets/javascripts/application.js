//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(function(){

$(".check-value").hide();
   
$("input:radio[name='user[is_active]']").change(function(){ 
         
    if(this.value == "false" && this.checked){
        $(".check-value").show();
    }else{
        $(".check-value").hide();
    }

    });

$( "#datepicker1" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1950:2000',dateFormat: 'yy-mm-dd'});
$( "#datepicker2" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1980:2050',dateFormat: 'yy-mm-dd'});
$( "#datepicker3" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '2000:2050',dateFormat: 'yy-mm-dd'});
});
