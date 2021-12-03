awk 'BEGIN {
  position=0
  depth=0
}
{
    direction=$1
    distance=$2
    switch (direction) {
    case "forward":
        # moving forward
        position+=distance
        break
    case "up":
        # Move up towards surface
        depth-=distance
        break
    case "down":
        # Dive
        depth+=distance
        break
    default:
        usage()
        break
    } 
} END {
  print "depth*position = ",depth*position
}'
