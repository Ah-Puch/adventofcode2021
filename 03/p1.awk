BEGIN {
#  for (j=1; j<=5;) {
#    one_in_pos[j++]=0
#    zero_in_pos[j++]=0
#  }
#  diag_cnt=0
}
{
  diagnostic=$1
  diag_size=length(diagnostic)
  diag_cnt+=1

  for (j=1; j<=diag_size;j++) {
    if (substr(diagnostic, j, 1)=="1") {
      one_in_pos[j]++
      printf "1"
    } else {
      zero_in_pos[j]++
      printf "0"
    }
  } 
  printf " "$1" "
  for (j=1; j<=diag_size;) {
    printf "%1d ",one_in_pos[j++]
  }
  printf "%1d\n",diag_cnt
} 
END {
    gamma=0
    epsilon=0
    for (j=1; j<=diag_size;j++) {
	if (one_in_pos[j]>zero_in_pos[j]) {
	    printf "1"
	    gamma+=2**(diag_size-j)
	} else {
	    printf "0"
	    epsilon+=2**(diag_size-j)
	}
    }    
    printf "\n"
    printf gamma"\n"
    printf epsilon"\n"
    printf "Power consumption = %d\n",gamma*epsilon
}


