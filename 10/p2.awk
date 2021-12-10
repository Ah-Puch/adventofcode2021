function push(stack, value){
    stack[++stack["lastss"]] = value
}

function pop(stack,locx){
    if(stack[mystack["lastss"]] < stack[stack["lastss"]]){
	return NULL
    } else {
	locx = stack[stack["lastss"]]
	delete stack[stack["lastss"]--]
	return locx
    }
}

function stacklook(stack, num){
    if(stack["firstss"] > stack["lastss"])
	return NULL # stack spent
    if(num <= 0){
	num = stack["lastss"] + num
	if(num < 1) return NULL
	return stack[num]
    } else {
	num = stack["firstss"] + num - 1
	if(num > stack["lastss"]) return NULL
	return stack[num]
    }
}

function stackoutofrange(stack, num){
    if(stack["firstss"] > stack["lastss"])
	return 3
    if(num <= 0){
	if(stack["lastss"] + num < stack["firstss"])
	    return(-1)
	else
	    return(0)
    } else {
	if(num + stack["firstss"] > stack["lastss"] +1)
	    return 1
	else
	    return 0
    }
}

function stackspent(stack){
    return (stack["firstss"] > stack["lastss"])
}

func get_values() {
    true=1
    false=0
    rows=0

    do {
	row+=1
	navmap[row][1]=""
	split($1, navmap[row], "")
    } while(getline)

    if (DEBUG) {
	print "-------------------------------------------------------"
	print_navmap()
    }
}

func print_navmap() {
    for (ph_i = 1; ph_i <= row; ph_i++) {
	for (ph_j = 1; ph_j <= length(navmap[ph_i]); ph_j++) {
	    printf "%s",navmap[ph_i][ph_j]
	}
	printf "\n"
    }
}



func check_map_line() {

    ### INITIALIZE mystack ###
    mystack["firstss"] = 10001
    mystack["lastss"] = 10000

    # Init right parenthesis
    r_par=">)]}"

    # Init left parenthesis
    l_par="<([{"

    # scoring table
    auto_score[")"]=1
    auto_score["]"]=2
    auto_score["}"]=3
    auto_score[">"]=4

    # scoring table
    auto_complete["("]=")"
    auto_complete["["]="]"
    auto_complete["{"]="}"
    auto_complete["<"]=">"

    # Fault sum

    for (ra_i = 1; ra_i <= row; ra_i++) {
	max_j=length(navmap[ra_i])
	faulty_line=false
	sum=0
        for (ra_j = 1; ra_j <= max_j; ra_j++) {
	    m_val=navmap[ra_i][ra_j]
	    if (index(l_par,m_val)) {
		if (DEBUG) printf "Have %s - push\n",m_val
		push(mystack, m_val)
	    } else {
		if (!stackspent(mystack)) {
		    p_val=pop(mystack)
		    if (DEBUG) printf "Pop %s - %s had\n",p_val,m_val
		} else {
		    if (DEBUG) print "=========================================Empty stack - INCOMPLETE line"
		    break
		}

		# Check for matching <>
		if (p_val=="<") {
		    # Check if we had > as mate
		    if (m_val!=">") {
			if (DEBUG) printf "Expected >, but found %s instead\n",m_val
			faulty_line=true
			break
		    }
		}

		# Check for matching ()
		if (p_val=="(") {
		    # Check if we had ) as mate
		    if (m_val!=")") {
			if (DEBUG) printf "Expected ), but found %s instead\n",m_val
			faulty_line=true
			break
		    }
		}

		# Check for matching []
		if (p_val=="[") {
		    # Check if we had ] as mate
		    if (m_val!="]") {
			if (DEBUG) printf "Expected ], but found %s instead\n",m_val
			faulty_line=true
			break
		    }
		}

		# Check for matching {}
		if (p_val=="{") {
		    # Check if we had } as mate
		    if (m_val!="}") {
			if (DEBUG) printf "Expected }, but found %s instead\n",m_val
			faulty_line=true
			break
		    }
		}
	    }
	}
	
	if (!faulty_line) {
	    if (DEBUG) {
		for (ph_j = 1; ph_j <= length(navmap[ra_i]); ph_j++) {
		    printf "%s",navmap[ra_i][ph_j]
		}
		printf "\n"
	    }

	    if (DEBUG) printf "-----------------------------print remaining of stack values\n"
	    while(!stackspent(mystack)) {
		p_val=pop(mystack)
		if (DEBUG) printf "%s",auto_complete[p_val]
		sum=sum*5+auto_score[auto_complete[p_val]]
	    }
	    if (DEBUG) printf "\n"
	    correct_line+=1
	    auto_sum[correct_line]=sum
	    if (DEBUG) printf "fault sum this line #%d = %d\n",correct_line,sum
	} else {
	    # Empty stack
	    while(!stackspent(mystack)) pop(mystack)
	}

	if (DEBUG) printf "-----------------------------Done with line\n"

    }

    asort(auto_sum)

    if (DEBUG) {
	printf "-----------------------------------------------------------------------------\n"
	for (ph_j = 1; ph_j <= length(auto_sum); ph_j++) print auto_sum[ph_j]
    }
    return auto_sum[int((correct_line+1)/2)]
}


BEGIN {
}
{
    get_values();
} 
END {
    check_map_line()
    printf "Sum of faults = %d\n",check_map_line()
}
