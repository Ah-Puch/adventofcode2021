BEGIN {
}
{
  diagnostic=$1
  diag_size=length(diagnostic)
  diag_cnt+=1

  for (j=1; j<=diag_size;j++) {
    if (substr(diagnostic, j, 1)=="1") {
      one_in_pos[j]++
    } else {
      zero_in_pos[j]++
    }
  } 
} 
END {
    gamma=0
    epsilon=0
    for (j=1; j<=diag_size;j++) {
	if (one_in_pos[j]>zero_in_pos[j]) {
	    gamma+=2**(diag_size-j)
	} else {
	    epsilon+=2**(diag_size-j)
	}
    }    
    printf "Power consumption = gamma*epsilon = %d*%d = %d\n",gamma,epsilon,gamma*epsilon
}


