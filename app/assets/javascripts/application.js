  //= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
$(document).ready(function(){

$(".check-value").hide();
   
$("input:radio[name='user[is_active]']").change(function(){ 
  // alert('entered') 
         
    if(this.value == "false" && this.checked){
    //	alert('oookss');
        $(".check-value").show();
    }else{
        $(".check-value").hide();
    }

    });

});