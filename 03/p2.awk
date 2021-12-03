func bit_to_keep_pos_n(arr,n,part) { 
    cnt_one=0
    cnt_zero=0
    for (j=0; j<length(arr);) {
	if (substr(arr[j++], n, 1)=="1") {
	    cnt_one++
	} else {
	    cnt_zero++
	}
    }
    if (part == "generator") {
	if (cnt_one >= cnt_zero) return "1"
	return "0"
    }
    if (part == "scrubber") {
	if (cnt_zero <= cnt_one) return "0"
	return "1"
    }
} 

func bin2dec(s) {
    s_size=length(s)
    res=0
    for (j=1; j<=s_size;j++) {
        if (substr(s, j, 1)=="1") {
	    res+=2**(s_size-j)
	}
    }
    return res
}

BEGIN {
}
{
  diag_in[diag_cnt++]=$1
} 
END {
    oxy_part["scrubber"]=""
    oxy_part["generator"]=""

    for (part in oxy_part) {
	delete diag
	for (j=0; j<length(diag_in);j++) {
	    diag[j]=diag_in[j]
	}

        pos=1
	while(length(diag)>1) {
	    bit_to_keep=bit_to_keep_pos_n(diag,pos,part)
	    delete new_diag
	    i=0
	    for (j=0; j<length(diag);j++) {
		bit=substr(diag[j], pos, 1)
		if ((bit==bit_to_keep)) {
		    new_diag[i++]=diag[j]
		} 
	    }
	    delete diag
	    for (j=0; j<length(new_diag);j++) {
		diag[j]=new_diag[j]
		oxy_part[part]=new_diag[j]
	    }
	    pos++
	}
    }

    printf "Life support rating = %d\n",bin2dec(oxy_part["generator"])*bin2dec(oxy_part["scrubber"])

}


