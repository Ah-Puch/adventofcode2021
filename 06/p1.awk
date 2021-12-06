func get_initial_state() {
    split($1,lanternfish,",")

    if (DEBUG) {
	printf "Initial state: "
	print_state_of_lanternfish()
    }
}

func print_state_of_lanternfish() {
    for (p_i = 1; p_i <= length(lanternfish); p_i++) {
	printf "%d ",lanternfish[p_i]
    }
    printf "\n"
}

func school_fish_up_to_day(n) {

    for (i = 1; i <= n; i++) {
	initial_size=length(lanternfish)
	current_size=initial_size
	for (j = 1; j <= initial_size; j++) {
	    if (lanternfish[j]==0) {
		lanternfish[j]=6
		current_size+=1
		lanternfish[current_size]=8
	    } else {
		lanternfish[j]-=1
	    }
	}

	if (DEBUG) {
	    if (i==1) {
		printf "After  1 day:  "
	    } else {
		printf "After %2d days: ",i
	    }
	    print_state_of_lanternfish()
	}
    }

    return length(lanternfish)
}

BEGIN {
}
{
    get_initial_state()
} 
END {

    printf "\n\nNumber of fish after %d days = %d\n",DAYS_OF_SCHOOLING,school_fish_up_to_day(DAYS_OF_SCHOOLING)

}


