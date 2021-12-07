# AoC 2021 - day 7
# Part 1
#
# Thomas Johansson , thomas.johansson@liu.se
#
func abs(v) {
    return v < 0 ? -v : v
}

func get_initial_state() {
    split($1,crab,",")

    if (DEBUG) {
	printf "Initial state: "
	print_state_of_crab()
    }
}

func print_state_of_crab() {
    for (p_i = 1; p_i <= length(crab); p_i++) {
	printf "%d ",crab[p_i]
    }
    printf "\n"
}

func min_crab_position() {
    pos=99999999999999
    for (p_i = 1; p_i <= length(crab); p_i++) {
	if (crab[p_i]<pos) pos=crab[p_i]
    }
    return pos
}

func max_crab_position() {
    pos=0
    for (p_i = 1; p_i <= length(crab); p_i++) {
	if (crab[p_i]>pos) pos=crab[p_i]
    }
    return pos
}

func calc_min_fuel_cost() {
    min_cost=9999999999

    for (i = min_crab_position(); i <= max_crab_position(); i++) {
	cost=0
	for (j = 1; j <= length(crab); j++) {
	    cost+=(abs(crab[j]-i))*(abs(crab[j]-i)+1)/2
	}
	if (cost<min_cost) min_cost=cost

	if (DEBUG) {
	    printf "Position=%3d    Cost=%3d   MinCost=%3d\n",i,cost,min_cost
	}
    }

    return min_cost
}

BEGIN {
}
{
    get_initial_state()
} 
END {

    printf "\n\nMin cost = %d\n",calc_min_fuel_cost()

}


