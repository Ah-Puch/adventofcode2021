func get_values() {
    i=0
    do {
	OUTPUTS=0
	for (i = 1; i <= NF; i++) {
	    l=length($i)
	    if (OUTPUTS) {
		if ((l==2)||(l==3)||(l==4)||(l==7)) cnt+=1
	    } else {
		if ($i=="|") OUTPUTS=1
	    }
	}
    } while(getline)

    printf "count of 1,4,7,8 = %d\n",cnt
}

BEGIN {
}
{
    get_values();
} 
END {
}
