awk 'BEGIN {
  position=0
  depth=0
  aim=0
}
{
    direction=$1
    distance=$2
    switch (direction) {
    case "forward":
        # moving forward
        position+=distance
        depth=depth+aim*distance
        break
    case "up":
        # Move up towards surface
        aim-=distance
        break
    case "down":
        # Dive
        aim+=distance
        break
    default:
        usage()
        break
    } 
} END {
  print "depth*position = ",depth*position
}'
