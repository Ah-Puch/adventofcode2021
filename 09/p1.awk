func get_values() {
    true=1
    false=0
    rows=0

    do {
	row+=1
	heightmap[row][1]=""
	split($1, heightmap[row], "")
    } while(getline)

    if (DEBUG) {
	print "-------------------------------------------------------"
	print_heightmap()
    }
}

func print_heightmap() {
    for (ph_i = 1; ph_i <= row; ph_i++) {
	for (ph_j = 1; ph_j <= length(heightmap[ph_i]); ph_j++) {
	    printf "%s",heightmap[ph_i][ph_j]
	}
	printf "\n"
    }
}

func risk_assessment() {
    max_j=length(heightmap[1])
    sum_of_risk_level=0
    for (ra_i = 1; ra_i <= row; ra_i++) {
        for (ra_j = 1; ra_j <= max_j; ra_j++) {
	    low=true
	    if (DEBUG) printf "Coordinate (%d,%d)\n",ra_i,ra_j
	    if (ra_i>1) {
		if (ra_j>1) {
		    # Check i-1,j-1
		    if (heightmap[ra_i][ra_j]>=heightmap[ra_i-1][ra_j-1]) low=false
		    if (DEBUG) printf "    Check i,j vs i-1,j-1 -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i-1][ra_j-1],low
		}
		if (ra_j<max_j) {
		    # Check i-1,j+1
		    if (heightmap[ra_i][ra_j]>=heightmap[ra_i-1][ra_j+1]) low=false
		    if (DEBUG) printf "    Check i,j vs i-1,j+1 -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i-1][ra_j+1],low
		}
		# Check i-i,j
		if (heightmap[ra_i][ra_j]>=heightmap[ra_i-1][ra_j]) low=false
		if (DEBUG) printf "    Check i,j vs i-1,j   -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i-1][ra_j],low
	    }
	    if (ra_i<row) {
		if (ra_j>1) {
		    # Check i+1,j-1
		    if (heightmap[ra_i][ra_j]>=heightmap[ra_i+1][ra_j-1]) low=false
		    if (DEBUG) printf "    Check i,j vs i+1,j-1 -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i+1][ra_j-1],low
		}
		if (ra_j<max_j) {
		    # Check i+1,j+1
		    if (heightmap[ra_i][ra_j]>=heightmap[ra_i+1][ra_j+1]) low=false
		    if (DEBUG) printf "    Check i,j vs i+1,j+1 -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i+1][ra_j+1],low
		}
		# Check i+1,j
		if (heightmap[ra_i][ra_j]>=heightmap[ra_i+1][ra_j]) low=false
		if (DEBUG) printf "    Check i,j vs i+1,j   -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i+1][ra_j],low
	    }
	    if (ra_j>1) {
		# Check i,j-1
		if (heightmap[ra_i][ra_j]>=heightmap[ra_i][ra_j-1]) low=false
		if (DEBUG) printf "    Check i,j vs i,j-1   -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i][ra_j-1],low
	    }
	    if (ra_j<max_j) {
		# Check i,j+1
		if (heightmap[ra_i][ra_j]>=heightmap[ra_i][ra_j+1]) low=false
		if (DEBUG) printf "    Check i,j vs i,j+1   -- %d vs %d  --> %d\n",heightmap[ra_i][ra_j],heightmap[ra_i][ra_j+1],low
	    }
	    if (low) {
		if (DEBUG) printf "--------------------------------------low at (%d,%d) with value %d\n",ra_i,ra_j,heightmap[ra_i][ra_j],low
		sum_of_risk_level+=(heightmap[ra_i][ra_j]+1)
	    }
        }
    }
    return sum_of_risk_level
}


BEGIN {
}
{
    get_values();
} 
END {
    printf "Sum of risk level = %d\n",risk_assessment()
}
