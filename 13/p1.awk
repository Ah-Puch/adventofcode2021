func get_coordinates() {
    i=1

    do {
	split($1,pos,",")

	# For now, only consider horizontal and vertical lines:
	# lines where either x1 = x2 or y1 = y2.
	coord[i]["x"]=pos[1]
	coord[i++]["y"]=pos[2]
	if (pos[2]>coord_y_max) coord_y_max=pos[2]
	if (pos[1]>coord_x_max) coord_x_max=pos[2]
	getline
    } while(length($1)>0)

    do {getline} while(length($1)==0)

    i=1
    do {
        split($3,foldline,"=")

        fold[i]["axis"]=foldline[1]
        fold[i++]["value"]=foldline[2]
    } while(getline)

    if (DEBUG) {
        print_coordinates()
    }
}

func print_coordinates() {
    print "-------------------------------------------------------"
    for (i = 1; i <= length(coord); i++) {
	printf "%d,%d\n",coord[i]["x"],coord[i]["y"]
	print "-------------------------------------------------------"
    }
    printf "max x coordinate = %d\n",coord_x_max
    printf "max y coordinate = %d\n",coord_y_max

    for (i = 1; i <= length(fold); i++) {
	printf "Fold along %s=%d",fold[i]["axis"],fold[i]["value"]
	print "-------------------------------------------------------"
    }
}

func visible_dots() {
    dot_cnt=0
    for (i = 0; i <= coord_y_max; i++) {
        for (j = 0; j <= coord_x_max; j++) {
            if (diagram[i][j]>0) dot_cnt+=1
        }
    }
    return dot_cnt
}


func init_diagram() {
    for (i = 0; i <= coord_y_max; i++) {
	for (j = 0; j <= coord_x_max; j++) {
	    diagram[i][j]=0
	}
    }
    for (i = 1; i <= length(coord); i++) {
	diagram[coord[i]["y"]][coord[i]["x"]]=1
    }

    if (DEBUG) {
        print_diagram()
    }

}

function dot(v) {return v > 0 ? "#" : "."}

func print_diagram() {
    print "-------------------------------------------------------"
    for (i = 0; i <= coord_y_max; i++) {
        for (j = 0; j <= coord_x_max; j++) {
	    printf "%s",dot(diagram[i][j])
        }
	printf "\n"
    }
}


func fold_diagram() {
#        fold[i]["axis"]=foldline[1]
#        fold[i++]["value"]=foldline[2]

    print "-------------------------------------------------------"
    for (f = 1; f <= length(fold); f++) {
	if (fold[f]["axis"]=="x") {
	    if (DEBUG) printf "fold at x=%d\n",fold[f]["value"]
	    if (DEBUG) printf "coord_y_max=%d  coord_x_max=%d\n",coord_y_max,coord_x_max
	    for (f_i = 0; f_i <= coord_y_max; f_i++) {
		for (f_j = 0; f_j < fold[f]["value"]; f_j++) {
		    diagram[f_i][f_j]+=diagram[f_i][(fold[f]["value"])*2-f_j]
		}
	    }
	    coord_x_max=fold[f]["value"]-1
	    if (DEBUG) printf "--> coord_y_max=%d  coord_x_max=%d\n",coord_y_max,coord_x_max
	}
	if (fold[f]["axis"]=="y") {
	    if (DEBUG) printf "fold at y=%d\n",fold[f]["value"]
	    if (DEBUG) printf "coord_y_max=%d  coord_x_max=%d\n",coord_y_max,coord_x_max
	    for (f_i = 0; f_i < fold[f]["value"]; f_i++) {
		for (f_j = 0; f_j <= coord_x_max; f_j++) {
		    diagram[f_i][f_j]+=diagram[(fold[f]["value"])*2-f_i][f_j]
		}
	    }
	    coord_y_max=fold[f]["value"]-1
	    if (DEBUG) printf "--> coord_y_max=%d  coord_x_max=%d\n",coord_y_max,coord_x_max
	}
	if (DEBUG) {
	    print_diagram()
	    if (DEBUG) printf "====> Visible dots=%d\n",visible_dots()
	}
    }
}


BEGIN {
}
{
    number_of_coordinates=get_coordinates()
} 
END {

    init_diagram()
    fold_diagram()
    printf "Visible dots=%d\n",visible_dots()
}


