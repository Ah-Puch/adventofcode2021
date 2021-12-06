func get_initial_state() {
    split($1,lanternfish,",")

    # Cycle of 9 days newborn fishes
    # Cycle of 7 days for existing fishes
    fishes_on_day[8]=0
    fishes_on_day[7]=0
    fishes_on_day[6]=0
    fishes_on_day[5]=0
    fishes_on_day[4]=0
    fishes_on_day[3]=0
    fishes_on_day[2]=0
    fishes_on_day[1]=0
    fishes_on_day[0]=0

    for (p_i = 1; p_i <= length(lanternfish); p_i++) {
       fishes_on_day[lanternfish[p_i]]+=1
    }

    if (DEBUG) {
	printf "Initial state: "
	print_state_of_lanternfish()
	print_fishes_on_day()
    }
}

func print_state_of_lanternfish() {
    sum=0
    for (p_i = 1; p_i <= length(lanternfish); p_i++) {
	printf "%d ",lanternfish[p_i]
    }
    printf "\n" 
}

func print_fishes_on_day() {
    print "-------------------------------------------------------"
    for (p_i = 8; p_i >= 0; p_i--) {
	printf "Fishes on day %d = %d\n",p_i,fishes_on_day[p_i]
    }
    printf "Totalt amount of fish = %d\n",amount_of_fish()
}

func amount_of_fish() {
    sum=0
    for (p_i = 8; p_i >= 0; p_i--) {
	sum+=fishes_on_day[p_i]
    }
    return sum
}

func school_fish_up_to_day(n) {

    for (i = 1; i <= n; i++) {
	
	new_born_fishes  = fishes_on_day[0]

        fishes_on_day[0] = fishes_on_day[1]
        fishes_on_day[1] = fishes_on_day[2]
        fishes_on_day[2] = fishes_on_day[3]
        fishes_on_day[3] = fishes_on_day[4]
        fishes_on_day[4] = fishes_on_day[5]
        fishes_on_day[5] = fishes_on_day[6]
        fishes_on_day[6] = fishes_on_day[7] + new_born_fishes
        fishes_on_day[7] = fishes_on_day[8]
        fishes_on_day[8] = new_born_fishes

	if (DEBUG) {
	    print_fishes_on_day()
	}
    }
    return amount_of_fish()
}

BEGIN {
}
{
    get_initial_state()
} 
END {

    printf "\n\nNumber of fish after %d days = %d\n",DAYS_OF_SCHOOLING,school_fish_up_to_day(DAYS_OF_SCHOOLING)

}


