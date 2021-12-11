func get_values() {
    true=1
    false=0
    rows=0

    do {
	row+=1
	octomap[row][1]=""
	split($1, octomap[row], "")
    } while(getline)

    if (DEBUG) {
	print_octomap()
	print "################################################################## END step 0"	
    }
}

func print_octomap() {
    for (ph_i = 1; ph_i <= row; ph_i++) {
	for (ph_j = 1; ph_j <= length(octomap[ph_i]); ph_j++) {
	    printf "%2s ",octomap[ph_i][ph_j]
	}
	printf "\n"
    }
    printf "\n"
}

func increase_lvl() {
    max_ph_j=length(octomap[1])
    for (ph_i = 1; ph_i <= row; ph_i++) {
        for (ph_j = 1; ph_j <= max_ph_j; ph_j++) {
            octomap[ph_i][ph_j]+=1
        }
    }
}

func flash_octo(y,x) {
    max_y=row
    max_x=length(octomap[1])
    if (y>1) {
	if (x>1) {
	    # Check y-1,x-1
	    if (octomap[y-1][x-1]>0) octomap[y-1][x-1]+=1
	}
	if (x<max_x) {
	    # Check y-1,x+1
	    if (octomap[y-1][x+1]>0) octomap[y-1][x+1]+=1
	}
	# Check y-i,x
	if (octomap[y-1][x]>0) octomap[y-1][x]+=1 
    }
    if (y<max_y) {
	if (x>1) {
	    # Check y+1,x-1
	    if (octomap[y+1][x-1]>0) octomap[y+1][x-1]+=1
	}
	if (x<max_x) {
	    # Check y+1,x+1
	    if (octomap[y+1][x+1]>0) octomap[y+1][x+1]+=1
	}
	# Check y+1,x
	if (octomap[y+1][x]>0) octomap[y+1][x]+=1
    }
    if (x>1) {
	# Check y,x-1
	if (octomap[y][x-1]>0) octomap[y][x-1]+=1
    }
    if (x<max_x) {
	# Check y,x+1
	if (octomap[y][x+1]>0) octomap[y][x+1]+=1
    }
}

func count_flashes() {
    max_j=length(octomap[1])
    flashes=0
    step=0

    do {
	increase_lvl()
	do {
	    octo_has_flashed=false
	    for (ra_i = 1; ra_i <= row; ra_i++) {
		for (ra_j = 1; ra_j <= max_j; ra_j++) {
		    if (octomap[ra_i][ra_j]>9) {
			flash_octo(ra_i,ra_j)
			octomap[ra_i][ra_j]=0
			octo_has_flashed=true
			flashes+=1
		    }
		}
	    }
	} while(octo_has_flashed)

	step+=1
	if (DEBUG) {
	    print_octomap()
	    print "################################################################## END step "step
	}
    } while(step<MAX_STEP)

    return flashes
}



BEGIN {
}
{
    get_values();
} 
END {
    printf "Running %d steps produced %d flashes\n",MAX_STEP,count_flashes()
}
