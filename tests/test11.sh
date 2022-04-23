echo "Running test11..."
echo

out=$(sudo ./main <tests/input11.txt >outputs/output11.txt)
output=$(sort outputs/output11.txt)
expected_output='a 1
all 2
application 1
as 1
ascii 1
but 1
characters 1
course 1
file 1
for 1
fun 3
have 2
hello 1
implement 1
in 1
is 1
make 1
most 1
operating 1
project 1
projects 1
sure 1
systems 1
test 1
the 2
to 1
we 1
were 1
wordcount 2'

if [ $? -eq 0 ] ; then
  echo "Pass: Program exited zero"
else
  echo "Fail: Program did not exit zero"
  exit 1
fi

if [ "$output" == "$expected_output" ] ; then
  echo "Pass: Output is correct"
else
  echo "Expected '$expected_output' but got: $output"
  exit 1
fi

echo
echo "Test11 passed."

exit 0
