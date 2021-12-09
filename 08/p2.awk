func init_num2p() {

    delete num2p

    num2p[0][1]=""
    num2p[1][1]=""
    num2p[2][1]=""
    num2p[3][1]=""
    num2p[4][1]=""
    num2p[5][1]=""
    num2p[6][1]=""
    num2p[7][1]=""
    num2p[8][1]=""
    num2p[9][1]=""

    if (DEBUG) {
	print "Initialised empty array"
	print_num2p()
    }
}

func get_values() {
    i=0
    total=0
    true=1
    false=0
    pattern_not_within=false
    pattern_within=true

    do {
	INPUTS=1
	display=0
	sum=0
	init_num2p()
	for (i = 1; i <= NF; i++) {
	    if (INPUTS) {
		if ($i=="|") {
		    INPUTS=0
		    if (DEBUG) {
			for (c_i in pattern) {
			    printf "FINAL pattern is %s\n",pattern[c_i]
			}
		    }
		    calculate_mapping()
		} else {
		    pattern[i]=sort_pattern($i)
		}
	    } else {
		old_sum=sum
		sum=10*old_sum+p2num[sort_pattern($i)]
		if (DEBUG) {
		    printf "pattern=%-10s old_sum=%4d  digit=%d  sum=%4d\n",sort_pattern($i),old_sum,p2num[sort_pattern($i)],sum
		}
	    } 
	}
	total+=sum
	if (DEBUG) {
	    print "-------------------------------------------------------"
	}
    } while(getline)

    printf "count of patterns = %d\n",total
}


func sort_pattern(str_in) {
    split(str_in, arr, "")
    asort(arr)

    str2 = ""
    for (ssi=1; ssi in arr; ssi++) str2 = str2 arr[ssi]

    return str2
}

func split_pattern(n) {
#    split("a,b,c,e,f,g",seg2num[0],",")
    for (sp_i = 1; sp_i <= length(pattern[c_i]); sp_i++) {
      num2p[n][sp_i]=substr(pattern[c_i],sp_i,1)
    }
    if (DEBUG) {
	print_num2p()
    }
}

func calculate_mapping() {
#    for (c_i = 1; c_i <= length(pattern); c_i++) {
#    for (c_i in pattern) {
#        printf "pattern is %s\n",pattern[c_i]
#    }

    for (c_i in pattern) {
	l=length(pattern[c_i])
#	l=length($c_i)
	if (l==2) {
	    p2num[pattern[c_i]]=1
	    split_pattern(1)
	}
	if (l==3) {
	    p2num[pattern[c_i]]=7
	    split_pattern(7)
	}
	if (l==4) {
	    p2num[pattern[c_i]]=4
	    split_pattern(4)
	}
	if (l==7) {
	    p2num[pattern[c_i]]=8
	    split_pattern(8)
	}
    }

#    printf "Pattern for 6 = %s\n",p_in_pattern_length_len(1,6,pattern_not_within)
    p_in_pattern_length_len(1,6,pattern_not_within)
    p2num[pattern[c_i]]=6
    split_pattern(6)

#    printf "Pattern for 9 = %s\n",p_in_pattern_length_len(4,6,pattern_within)
    p_in_pattern_length_len(4,6,pattern_within)
    p2num[pattern[c_i]]=9
    split_pattern(9)

    for (c_i in pattern) {
        l=length(pattern[c_i])
        if (l==6) {
	    printf "mapping for 0 = %s\n",pattern[c_i]
	    if ((p2num[pattern[c_i]]!=9) && (p2num[pattern[c_i]]!=6)) {
		printf "mapping for 0 = %s\n",pattern[c_i]
		p2num[pattern[c_i]]=0
		split_pattern(0)
	    }
        }
    }

    p_in_pattern_length_len(1,5,pattern_within)
    p2num[pattern[c_i]]=3
    split_pattern(3)

    str6=""
    for (si=1; si in num2p[6]; si++) str6 = str6 num2p[6][si]

#    c_25=1
    for (c_i in pattern) {
        l=length(pattern[c_i])
        if (l==5) {
            if (p2num[pattern[c_i]]!=3) {
		if (count_common_segment(pattern[c_i],str6)==4) {
		    p2num[pattern[c_i]]=5
		    split_pattern(5)
		}
		if (count_common_segment(pattern[c_i],str6)==5) {
		    p2num[pattern[c_i]]=2
		    split_pattern(2)
		}
#                str_235[c_235++]=pattern[c_i]
            }
	}
    }

#    if (count_common_segment(str_235[1],str6)==5) {
#    } else {
#    }
#    printf "Common segments 6 (%s) - 2/3 (%s) = %d\n",str6,str_235[1],count_common_segment(str_235[1],str6)
#    printf "Common segments 6 (%s) - 2/3 (%s) = %d\n",str6,str_235[2],count_common_segment(str_235[2],str6)
#    printf "Common segments 2 (%s) - 3 (%s) = %d\n",str_235[2],str_235[3],count_common_segment(str_235[2],str_235[3])

}

func count_common_segment(a,b) {
    cnta=length(a)
    cntb=length(b)
    split(a,arr_a,"")
    split(b,arr_b,"")

    common=0
    for (cnt_ii in arr_a) {
	for (cnt_jj in arr_b) {
#	    printf "arr_a[cnt_ii] = %s -- arr_b[cnt_jj] = %s ---- ",arr_a[cnt_ii],arr_b[cnt_jj]
	    if (arr_a[cnt_ii]==arr_b[cnt_jj]) {
		common+=1
	    }
#	    printf "%d\n",common
	}
#	print "----------------------"
    }
    return common
}

func print_num2p_as_word(n) {
    for (pn_i = 1; pn_i <= length(num2p[n]); pn_i++) {
	printf "%s",num2p[n][pn_i]
    }
    printf "\n"
}

func print_num2p() {
    for (ps_i in num2p) {
	printf "%d - ",ps_i
	for (ps_j = 1; ps_j <= length(num2p[ps_i]); ps_j++) {
	    printf "%s,",num2p[ps_i][ps_j]
	}
            print " "
    }
        print "-------------------------------------------------------"
}

func p_in_pattern_length_len(digit,len,within) {

    res=false

#    printf "pattern to find = "
    print_num2p_as_word(digit)

#    printf "look in length  = %d\n",len

    for (c_i = 1; c_i <= length(pattern); c_i++) {
        l=length(pattern[c_i])
        if (l==len) {
#	    printf "pattern to look in = %s  ",pattern[c_i]
#	    if (within) {
	    res=true
#	    printf "WITHIN  "
	    for (w_i = 1; w_i <= length(num2p[digit]); w_i++) {
#		printf "%s",num2p[digit][w_i]
		if (!(index(pattern[c_i],num2p[digit][w_i]))) res=false
#		printf "-%d-",res
	    }
	    print "  "
	    if (within) {
		if (res) {
#		    print "TRUE"
		    return pattern[c_i]
		} else {
#		    print "FALSE"
		}
	    } else {
		if (res) {
#		    print "FALSE"
		} else {
#		    print "TRUE"
		    return pattern[c_i]
		}
	    }
        }
    }
}

BEGIN {
}
{
    get_values();
} 
END {
}
