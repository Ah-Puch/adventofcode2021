#0,9 -> 5,9
#8,0 -> 0,8
#9,4 -> 3,4
#2,2 -> 2,1
#7,0 -> 7,4
#6,4 -> 2,0
#0,9 -> 2,9
#3,4 -> 1,4
#0,0 -> 8,8
#5,5 -> 8,2

func get_coordinates() {
    i=0
    do {
	split($1,coord1,",")
	split($3,coord2,",")

	# For now, only consider horizontal and vertical lines:
	# lines where either x1 = x2 or y1 = y2.
	if (coord1[1]==coord2[1] || coord1[2]==coord2[2]) {
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
    for (i = 0; i <= coord_y_max; i++) {
        for (j = 0; j <= coord_x_max; j++) {
	    if (diagram[i][j]==0) {
		printf "."
	    } else {
		printf "%d",diagram[i][j]
	    }
        }
	printf "\n"
    }
}

func mark_lines_on_map() {
    for (i = 0; i < number_of_coordinates; i++) {
	# Extract coordinate pair #i
	if (coord[i]["x2"]>coord[i]["x1"]) {
	    x1=coord[i]["x1"]
	    x2=coord[i]["x2"]
	} else {
	    x1=coord[i]["x2"]
	    x2=coord[i]["x1"]
	}

	if (coord[i]["y2"]>coord[i]["y1"]) {
	    y1=coord[i]["y1"]
	    y2=coord[i]["y2"]
	} else {
	    y1=coord[i]["y2"]
	    y2=coord[i]["y1"]
	}

#	printf "i, (x1,y1), (x2,y2) = %d, (%d,%d), (%d,%d)\n",i,x1,y1,x2,y2
	for (y = y1; y <= y2; y++) {
	    for (x = x1; x <= x2; x++) {
		diagram[y][x]+=1
	    }
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

#func mark_number_om_boards(n) {
#    for (d_i = 1; d_i <= length(board); d_i++) {
#        for (d_j = 1; d_j <= 5; d_j++) {
#            for (d_k = 1; d_k <= 5; d_k++) {
#                if (board[d_i][d_j][d_k]==n) board[d_i][d_j][d_k]=-1
#            }
#        }
#    }
#}
#
#func bingo_on_board(n) {
#    bingo=0
#    for (b_i = 1; b_i <= 5; b_i++) {
#	bingo_h=1
#	bingo_v=1
#        for (b_j = 1; b_j <= 5; b_j++) {
#	    if (board[n][b_i][b_j]!=-1) bingo_h=0
#	}
#        for (b_j = 1; b_j <= 5; b_j++) {
#	    if (board[n][b_j][b_i]!=-1) bingo_v=0
#	}
#	bingo+=bingo_h
#	bingo+=bingo_v
#    }
#    return (bingo)
#}
#
#func winning_board_number() {
#    for (d_i = 1; d_i <= length(board); d_i++) {
#	if (bingo_on_board(d_i)) return d_i
#    }
#    return 0
#}
#
#func sum_all_of_all_unmarked_numbers(n) {
#    sum=0
#    for (b_i = 1; b_i <= 5; b_i++) {
#        for (b_j = 1; b_j <= 5; b_j++) {
#            if (board[n][b_i][b_j]>-1) sum+=board[n][b_i][b_j]
#        }
#    }
#    return (sum)
#}

BEGIN {
}
{
    number_of_coordinates=get_coordinates()
} 
END {

    init_diagram()
    mark_lines_on_map()

    printf "Numbers of overlapping points = %d\n",count_overlapping_points()

#    for (i in bingo_number) {
#        if (DEBUG) {
#	    print "=================================================================="
#	    printf "---- %d\n",bingo_number[i]
#	}
#	mark_number_om_boards(bingo_number[i])
#	winning_board=winning_board_number()
#	if (winning_board) {
#	    winning_sum=sum_all_of_all_unmarked_numbers(winning_board)
#	    printf "Winning board  = %d\n",winning_board
#	    printf "The sum is     = %d\n",winning_sum
#	    printf "Winning number = %d\n",bingo_number[i]
#	    break
#	}
#        if (DEBUG) {
#	    print_bingo_boards()
#	}
#    }
#	
#    printf "The winner is = %d\n",winning_sum*bingo_number[i]
#
}


