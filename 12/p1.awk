function descend(cave,path,cnt) {
    if (length(path)==0) {
	path=cave 
    } else {
	path=path","cave
    }
    if (cave!="end") {
	if ( isarray(map[cave]) ) {
	    for (child in map[cave]) {
		if (DEBUG) printf "isarray -- child=%s   path=%s\n",parent,child,path
		if (!((child==tolower(child)) && (index(path,tolower(child))))) cnt=descend(child,path,cnt)
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
