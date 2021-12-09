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
	    printf "%2s ",heightmap[ph_i][ph_j]
	}
	printf "\n"
    }
    printf "\n"
}

func risk_assessment() {
    max_j=length(heightmap[1])
    sum_of_risk_level=0
    basin_cnt=0
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
		basin_cnt+=1
		basin[basin_cnt][0]=ra_j
		basin[basin_cnt][1]=ra_i
	    }
        }
    }
    return sum_of_risk_level
}

func mark_basins() {
    # mark basin low points
    for (ra_i = 1; ra_i <= basin_cnt; ra_i++) {
	x0=basin[ra_i][0]
	y0=basin[ra_i][1]
	if (DEBUG) printf "Coordinate (%d,%d)\n",y0,x0
	heightmap[basin[ra_i][1]][basin[ra_i][0]]=-1*ra_i
    }
    if (DEBUG) print_heightmap()

    max_j=length(heightmap[1])
    do {
	non_basin=false
	for (ra_i = 1; ra_i <= row; ra_i++) {
	    for (ra_j = 1; ra_j <= max_j; ra_j++) {
		val=heightmap[ra_i][ra_j]
		if (DEBUG) printf "Coordinate (%d,%d) - %d\n",ra_i,ra_j,val
		if ((val>=0) && (val<9)) non_basin=true
		if (val<0) {
		    if (ra_i>1) {
			# Set i-i,j
			if (heightmap[ra_i-1][ra_j]<9) heightmap[ra_i-1][ra_j]=val
		    }
		    if (ra_i<row) {
			# Set i+1,j
			if (heightmap[ra_i+1][ra_j]<9) heightmap[ra_i+1][ra_j]=val
		    }
		    if (ra_j>1) {
			# Set i,j-1
			if (heightmap[ra_i][ra_j-1]<9) heightmap[ra_i][ra_j-1]=val
		    }
		    if (ra_j<max_j) {
			# Set i,j+1
			if (heightmap[ra_i][ra_j+1]<9) heightmap[ra_i][ra_j+1]=val
		    }
		}
		if (DEBUG) print_heightmap()
	    }
	}
    } while(non_basin)

    for (ra_b = 1; ra_b <= basin_cnt; ra_b++) {
        for (ra_i = 1; ra_i <= row; ra_i++) {
            for (ra_j = 1; ra_j <= max_j; ra_j++) {
		if (heightmap[ra_i][ra_j] == -1*ra_b) {
		    basin_val[ra_b]+=1
		}
	    }
	}
	if (DEBUG) printf "basin #%d has_size %d\n",ra_b,basin_val[ra_b]
    }

    asort(basin_val)
    basin_prod=1
    for (ra_b = length(basin_val)-2; ra_b <= length(basin_val); ra_b++) {
	basin_prod=basin_prod*basin_val[ra_b]
    }

    printf "\n\nProduct of three largest basins = %d\n",basin_prod

}


BEGIN {
}
{
    get_values();
} 
END {
    printf "Sum of risk level = %d\n",risk_assessment()
    mark_basins()
}
