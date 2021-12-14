func get_input() {
    i=0

    # Assign starting template
    template=$1

    do {getline} while(length($1)==0)

    # Read translation rule set
    do {
	rule[$1]=$3
    } while(getline)

    if (DEBUG) {
        print_input()
    }
}

func print_input() {
    print "-------------------------------------------------------"
    printf "Template: %s\n",template
    for (i in rule) {
	printf "%s -> %s\n",i,rule[i]
    }
}

func insert_elements(str_in) {
    str_out=""
    for (i = 1; i < length(str_in); i++) {
	elem=substr(str_in,i,2)
	str_out=sprintf("%s%s%s",str_out,substr(str_in,i,1),rule[elem])
	if (DEBUG) printf "elem #%d = %s -> %s\n",i,elem,str_out
    }
    str_out=sprintf("%s%s",str_out,substr(str_in,length(str_in),1))
    if (DEBUG) printf "elem #%d = %s -> %s\n",i,elem,str_out

    return str_out
}

func frequency_stats(str_in) {
    split(str_in,str_arr,"")

    delete C
    for(i=1; i in str_arr; i++)	C[str_arr[i]]++

    asort(C)
    if (DEBUG) {
	for (i=1; i in C; i++) printf "%s -> %s\n",i,C[i]
    }

    f_high=C[length(C)]
    f_low=C[1]

    if (DEBUG) printf "Diff high %d - low %d = %d\n",f_high,f_low,(f_high-f_low)

    return (f_high-f_low)
}



BEGIN {
}
{
    number_of_rules=get_input()
} 
END {
    polymer=template
    for (step=1; step<=MAX_STEP; step++) {
	polymer=insert_elements(polymer)
    }
    printf "diff = %d\n",frequency_stats(polymer)
}


