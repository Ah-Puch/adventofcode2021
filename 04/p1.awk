func get_bingo_numbers() {
    split($0,bingo_number,",")
    getline

    if (DEBUG) {
	print_bingo_numbers()
    }
}

func print_bingo_numbers() {
    for (i in bingo_number) {
	printf "%d ",bingo_number[i]
    }
    printf "\n\n"
}

func get_bingo_boards() {
    do {
	if (NF>0) {
	    for (j = 1; j <= 5; j++) board[board_number][i][j]=$j		
	    i+=1
	} else {
	    i=1
	    board_number+=1
	}
    } while(getline)

    if (DEBUG) {
        print_bingo_boards()
    }
}

func print_bingo_boards() {
    for (d_i = 1; d_i <= length(board); d_i++) {
	for (d_j = 1; d_j <= 5; d_j++) {
	    for (d_k = 1; d_k <= 5; d_k++) {
		printf "%2d ",board[d_i][d_j][d_k]
	    }
	    printf "\n"
	}
	if (DEBUG) {
	    if (bingo_on_board(d_i)) print "----------------------BINGO"
	}
	printf "\n"
    }
}

func mark_number_om_boards(n) {
    for (d_i = 1; d_i <= length(board); d_i++) {
        for (d_j = 1; d_j <= 5; d_j++) {
            for (d_k = 1; d_k <= 5; d_k++) {
                if (board[d_i][d_j][d_k]==n) board[d_i][d_j][d_k]=-1
            }
        }
    }
}

func bingo_on_board(n) {
    bingo=0
    for (b_i = 1; b_i <= 5; b_i++) {
	bingo_h=1
	bingo_v=1
        for (b_j = 1; b_j <= 5; b_j++) {
	    if (board[n][b_i][b_j]!=-1) bingo_h=0
	}
        for (b_j = 1; b_j <= 5; b_j++) {
	    if (board[n][b_j][b_i]!=-1) bingo_v=0
	}
	bingo+=bingo_h
	bingo+=bingo_v
    }
    return (bingo)
}

func winning_board_number() {
    for (d_i = 1; d_i <= length(board); d_i++) {
	if (bingo_on_board(d_i)) return d_i
    }
    return 0
}

func sum_all_of_all_unmarked_numbers(n) {
    sum=0
    for (b_i = 1; b_i <= 5; b_i++) {
        for (b_j = 1; b_j <= 5; b_j++) {
            if (board[n][b_i][b_j]>-1) sum+=board[n][b_i][b_j]
        }
    }
    return (sum)
}

BEGIN {
}
{
    get_bingo_numbers()
    get_bingo_boards()
} 
END {

    for (i in bingo_number) {
        if (DEBUG) {
	    print "=================================================================="
	    printf "---- %d\n",bingo_number[i]
	}
	mark_number_om_boards(bingo_number[i])
	winning_board=winning_board_number()
	if (winning_board) {
	    winning_sum=sum_all_of_all_unmarked_numbers(winning_board)
	    printf "Winning board  = %d\n",winning_board
	    printf "The sum is     = %d\n",winning_sum
	    printf "Winning number = %d\n",bingo_number[i]
	    break
	}
        if (DEBUG) {
	    print_bingo_boards()
	}
    }
	
    printf "The winner is = %d\n",winning_sum*bingo_number[i]

}


