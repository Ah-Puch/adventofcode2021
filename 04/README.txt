cat input-demo | awk -f p1.awk DEBUG=1
cat input-demo | awk -f p1.awk
cat input      | awk -f p1.awk

cat input-demo | awk -f p2.awk DEBUG=1
cat input-demo | awk -f p2.awk
cat input      | awk -f p2.awk


aoc [~/github/adventofcode2021/04]> cat input      | awk -f p1.awk
Winning board  = 41
The sum is     = 829
Winning number = 17
The winner is = 14093


aoc [~/github/adventofcode2021/04]> cat input      | awk -f p2.awk

The winner num = Last_bingo_number * sum_of_remainign_numbers = 36 * 483 = 17388
