function duplicate_visit(str) {
    true=1
    false=0
    cnt=0
    unique=0

    split(str,arr,",")

    delete C
    for(i=1; i in arr; i++){
	if (!((arr[i]=="start")||(arr[i]=="end")||(arr[i]==toupper(arr[i])))) {
	    cnt+=1
	    if(!C[arr[i]]++) unique+=1
	}
    }
    return (cnt-unique)
}

function descend(cave,path,cnt) {
    if (length(path)) {
	path=path","cave
    } else {
	path=cave 
    }
    if (cave!="end") {
	if ( isarray(map[cave]) ) {
	    for (child in map[cave]) {
		if (DEBUG) printf "isarray1 -- child=%s   path=%s   dupl=%d\n",child,path,duplicate_visit(path)
		if (child!="start") {
		    if (DEBUG) printf "isarray2 --- child=%s   path=%s   dupl=%d\n",child,path,duplicate_visit(path)
		    if (!((child==tolower(child)) && (index(path,tolower(child))) && (duplicate_visit(path)>0))) {
			cnt=descend(child,path,cnt)
		    }
		}
	    }
	}
    } else {
	cnt+=1
	if (DEBUG) printf "notarray -- child=%s   path=%s\n",cave,path
	if (VERBOSE||DEBUG) printf "----------------------------------------------------- Complete path %s\n",path
    } 
    return cnt
}
BEGIN { FS="-" }

NR==1 { root = "start" }
{ 
    # Build cave map
    map[$1][$2] 
    map[$2][$1] 
}

END { 
    printf "Number of paths = %d\n",descend(root) 
}
