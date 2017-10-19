function populateRuns(){
	runs_scored = document.getElementById('runs_scored');
	result = document.getElementById('result');
	if(result.value == '1 Run'){
		runs_scored.value = '1';
	}
	else if(result.value == '2 Runs'){
		runs_scored.value = '2';
	}
	else if(result.value == '3 Runs'){
		runs_scored.value = '3';
	}
	else if(result.value == '4 Runs'){
		runs_scored.value = '4';
	}
	else if(result.value == '5 Runs'){
		runs_scored.value = '5';
	}
	else if(result.value == '6 Runs'){
		runs_scored.value = '6';
	}
	else if(result.value == 'Wicket'){
		runs_scored.value = '0';
	}
	else if(result.value == 'Extra'){
		runs_scored.value = '0';
	}
	else if(result.value == 'Dead'){
		runs_scored.value = '0';
	}
}

function populateExtraRuns(){
	extra_runs = document.getElementById('extra_runs');
	extra = document.getElementById('extra_type');
	if(extra.value == 'Wide Ball'){
		extra_runs.value = '1';
	}
	else if(extra.value == 'No Ball'){
		extra_runs.value = '1';
	}
	else if(extra.value == 'Bye'){
		extra_runs.value = '1';
	}
	else if(extra.value == 'Leg Bye'){
		runs_scored.value = '1';
	}
}