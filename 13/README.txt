cat input-demo | awk -f p1.awk MAX_STEP=100 DEBUG=1
cat input-demo | awk -f p1.awk MAX_STEP=100
cat input      | awk -f p1.awk MAX_STEP=100

cat input-demo | awk -f p2.awk MAX_STEP=100 DEBUG=1
cat input-demo | awk -f p2.awk MAX_STEP=100
cat input      | awk -f p2.awk MAX_STEP=100


aoc [~/github/adventofcode2021/12]> cat input-small-1 | awk -f p2.awk
Number of paths = 36
aoc [~/github/adventofcode2021/12]> cat input-small-2 | awk -f p2.awk
Number of paths = 103
aoc [~/github/adventofcode2021/12]> cat input-demo | awk -f p2.awk
Number of paths = 3509
aoc [~/github/adventofcode2021/12]> cat input | awk -f p2.awk
Number of paths = 74222
