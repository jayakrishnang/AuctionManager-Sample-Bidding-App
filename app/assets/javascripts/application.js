//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.Jcrop
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


  $("input:checkbox[name='user[remove_avatar]']").change(function(){ 
         
    if(this.value == "false" && this.checked){
        $(".remove-avatar").show();
    }else{
        $(".remove-avatar").hide();
  }

});


$( "#datepicker1" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1950:2000',dateFormat: 'yy-mm-dd'});
$( "#datepicker2" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1980:2050',dateFormat: 'yy-mm-dd'});
$( "#datepicker3" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '2000:2050',dateFormat: 'yy-mm-dd'});
});

function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('preview').src=e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
        user[remove_avatar]=0
    }
}