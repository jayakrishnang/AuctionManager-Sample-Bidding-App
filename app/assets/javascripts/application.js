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

function validateBidding(){
  var balance = document.getElementById('bid_log_purse_balance').value;
  var bid_amount = document.getElementById('bid_log_amount').value;
  var base_points = document.getElementById('bid_log_base_points').value;
  var noOfPlayers = document.getElementById('bid_log_no_of_players').value;
  var currentBid = document.getElementById('current_bid_amount');
  var bid_closed = document.getElementById('bid_closed')
  if(bid_closed != null && bid_closed.value == 'true'){
    alert("Bidding closed. Please select next player!");
    return false;
  }
  if(parseInt(bid_amount) < parseInt(base_points)){
    alert("Bid amount is lesser than base price. Please increase bid amount!");
    return false;
  }
  if(currentBid != null && parseInt(currentBid.value) >= parseInt(bid_amount)){
    alert("Bid amount is lesser than current bid. Please increase bid amount!");
    return false;
  }
  if((parseInt(balance) - ((10 - parseInt(noOfPlayers)) * 5)) < parseInt(bid_amount)){
    alert("Insufficient balance! Remember you need to have 11 players in your team!");
    return false;
  }
  if(parseInt(noOfPlayers) == 11){
    alert("You currently have 11 players. You cannot bid anymore!");
    return false;
  }
  return true;
}