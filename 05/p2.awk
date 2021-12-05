# AoC 2021 - day 5
# Part 2
#
# Thomas Johansson , thomas.johansson@liu.se
# 
func abs(v) {
    return v < 0 ? -v : v
}

func get_coordinates() {
    i=0
    do {
	split($1,coord1,",")
	split($3,coord2,",")

	# For now, only consider horizontal and vertical lines:
	# lines where either x1 = x2 or y1 = y2.
	if ((coord1[1]==coord2[1] || coord1[2]==coord2[2]) ||
	    (abs(coord1[1]-coord2[1]) == abs(coord1[2]-coord2[2]))) {
	    if (coord1[1]>coord_x_max) coord_x_max=coord1[1]
	    if (coord1[2]>coord_y_max) coord_y_max=coord1[2]
	    if (coord2[1]>coord_x_max) coord_x_max=coord2[1]
	    if (coord2[2]>coord_y_max) coord_y_max=coord2[2]
	    coord[i]["x1"]=coord1[1]
	    coord[i]["y1"]=coord1[2]
	    coord[i]["x2"]=coord2[1]
	    coord[i]["y2"]=coord2[2]
	    i+=1
	}
    } while(getline)

    if (DEBUG) {
        print_coordinates()
    }

    return i
}

func print_coordinates() {
    print "-------------------------------------------------------"
    for (i = 0; i < length(coord); i++) {
	printf "%d,%d -> %d,%d\n",coord[i]["x1"],coord[i]["y1"],coord[i]["x2"],coord[i]["y2"]
	print "-------------------------------------------------------"
    }
    printf "max x coordinate = %d\n",coord_x_max
    printf "max y coordinate = %d\n",coord_y_max
}

func init_diagram() {
    for (i = 0; i <= coord_y_max; i++) {
	for (j = 0; j <= coord_x_max; j++) {
	    diagram[i][j]=0
	}
    }
    if (DEBUG) {
        print_diagram()
    }

}

func print_diagram() {
    print "-------------------------------------------------------"
    for (p_i = 0; p_i <= coord_y_max; p_i++) {
        for (p_j = 0; p_j <= coord_x_max; p_j++) {
	    if (diagram[p_i][p_j]==0) {
		printf "."
	    } else {
		printf "%d",diagram[p_i][p_j]
	    }
        }
	printf "\n"
    }
}

func mark_lines_on_map() {
    for (i = 0; i < number_of_coordinates; i++) {
	# Extract coordinate pair #i
	x1=coord[i]["x1"]
	x2=coord[i]["x2"]
	y1=coord[i]["y1"]
	y2=coord[i]["y2"]

	if (x1==x2 || y1==y2) {
	    # Straight lines
	    y=y1
	    not_ylimit=1
	    for (y=y1; not_ylimit; ) {
		not_xlimit=1
		for (x=x1; not_xlimit; ) {
		    diagram[y][x]+=1
		    
		    if (x<=x2) {
			x+=1
			if (x>x2) not_xlimit=0
		    } else {
			x-=1
			if (x<x2) not_xlimit=0
		    }
		}
		if (y<=y2) {
		    y+=1
		    if (y>y2) not_ylimit=0
		} else {
		    y-=1
		    if (y<y2) not_ylimit=0
		}
	    } 
	} else {
	    # Vertical lines
	    x=x1
	    not_ylimit=1
	    for (y=y1; not_ylimit; ) {
		diagram[y][x]+=1
		    
		if (x<=x2) {
		    x+=1
		} else {
		    x-=1
		}
		if (y<=y2) {
		    y+=1
		    if (y>y2) not_ylimit=0
		} else {
		    y-=1
		    if (y<y2) not_ylimit=0
		}
	    } 
	}

	if (DEBUG) {
	    print "======================================================="
	    printf ">>%d,%d -> %d,%d\n",coord[i]["x1"],coord[i]["y1"],coord[i]["x2"],coord[i]["y2"]
	    print_diagram()
	}
    }

    if (DEBUG) {
        print_diagram()
    }
}

func count_overlapping_points() {
    overlap=0
    for (i = 0; i <= coord_y_max; i++) {
        for (j = 0; j <= coord_x_max; j++) {
	    if (diagram[i][j]>1) overlap+=1
        }
    }
    return overlap
}

BEGIN {
}
{
    number_of_coordinates=get_coordinates()
} 
END {
    init_diagram()
    mark_lines_on_map()

    printf "Numbers of overlapping points = %d\n",count_overlapping_points()
}


