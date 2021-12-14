func get_input() {
    i=0

    # Assign starting template
    template=$1

    do {getline} while(length($1)==0)

    # Read translation rule set
    do {
	rule[$1][1]=sprintf("%s%s",substr($1,1,1),$3)
	rule[$1][2]=sprintf("%s%s",$3,substr($1,2,1))
    } while(getline)

    if (DEBUG) {
        print_input()
    }
}

func print_input() {
    print "-------------------------------------------------------"
    printf "Template: %s\n",template
    for (i in rule) {
	printf "%s -> %s,%s\n",i,rule[i][1],rule[i][2]
    }
}

func init_polymer() {
    for (i = 1; i < length(template); i++) {
	polymer[substr(template,i,2)]+=1
    }
    for (i = 1; i <= length(template); i++) {
	count[substr(template,i,1)]+=1
    }
    if (DEBUG) print_polymer()
}

func print_polymer() {
    for (i in polymer) {
        printf "--- print poly -- %s -> %d\n",i,polymer[i]
    }
    print "counter"
    sum=0
    for (i in count) {
        printf "--- print cntr -- %s -> %d\n",i,count[i]
	sum+=count[i]
    }
    print "--------------"
    print sum
}

func insert_elements() {
    delete new_polymer

    for (elem in polymer) {
	    if (DEBUG) {
		printf "--- insert - elem=%s\n", elem
		printf "--- insert -   new=%s\n", rule[elem][1]
		printf "--- insert -   new=%s\n", rule[elem][2]
	    }
	    new_polymer[rule[elem][1]]+=polymer[elem]
	    new_polymer[rule[elem][2]]+=polymer[elem]
	    count[substr(rule[elem][1],2,1)]+=polymer[elem]
    }
    delete polymer
    for (elem in new_polymer) polymer[elem]=new_polymer[elem]

    if (DEBUG) print_polymer()
}

func frequency_stats() {

    asort(count)

    if (DEBUG) print_polymer()

    f_high=count[length(count)]
    f_low=count[1]

    if (DEBUG) printf "Diff high %d - low %d = %d\n",f_high,f_low,(f_high-f_low)

    return (f_high-f_low)
}



BEGIN {
}
{
    number_of_rules=get_input()
} 
END {
    init_polymer()
    for (step=1; step<=MAX_STEP; step++) {
	if (DEBUG||VERBOSE) printf "------------------------------------------------------- print poly - step=%d\n",step
	insert_elements()
    }
    printf "diff = %d\n",frequency_stats()
}


