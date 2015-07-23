//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require jquery.Jcrop
//= require turbolinks
//= require_tree .
$(function(){

  $(".check-value").hide();
   
  $("input:radio[name='user[status]']").change(function(){ 
         
    if(this.value == "Locked" && this.checked){
      $(".check-value").show();
    }else{
      $(".check-value").hide();
    }

  });

  $("#remove").click(function(){
    var check = confirm("Do yo Really Want to Remove Your Profile Picture");
    if (check == true)
    {
      $("#preview").attr("src","/images/fallback/thumb_default.png");
      $("#remover").hide();
      $("#avatar").val("");
      // #$("#remove").attr('checked', false);    
    }
    else
    {
      $("#remove").attr('checked', false);
    }
  });



$( "#datepicker1" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1950:2000',dateFormat: 'yy-mm-dd'});
$( "#datepicker2" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '1980:2050',dateFormat: 'yy-mm-dd'});
$( "#datepicker3" ).datepicker({ changeYear: true, changeMonth: true, yearRange: '2000:2050',dateFormat: 'yy-mm-dd'});
});

function readURL(input) {

   $("#remover").show();
   $("#remove").attr('checked', false);
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById('preview').src=e.target.result;
        }
        reader.readAsDataURL(input.files[0]);
    }
}