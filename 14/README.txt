cat input-demo | awk -f p1.awk MAX_STEP=10 DEBUG=1
cat input-demo | awk -f p1.awk MAX_STEP=10
cat input      | awk -f p1.awk MAX_STEP=10

cat input-demo | awk -f p2.awk MAX_STEP=40 DEBUG=1
cat input-demo | awk -f p2.awk MAX_STEP=40
cat input      | awk -f p2.awk MAX_STEP=40


aoc [~/github/adventofcode2021/14]> cat input | awk -f p2.awk MAX_STEP=40
diff = 2914365137499
