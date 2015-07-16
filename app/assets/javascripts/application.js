  //= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
<script type="text/javascript" src="https://ajax.microsoft.com/ajax/jQuery/jquery-1.4.2.min.js">
</script>
<script type="text/javascript" >
$(document).ready(function(){
	$("#ToggleMe1a").click(function() {
		$("#ToggleMe1b").toggle();
	})
})
