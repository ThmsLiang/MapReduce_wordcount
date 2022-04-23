echo "Running test2..."
echo

out=$(sudo ./main <tests/input2.txt >outputs/output2.txt)
output=$(sort outputs/output2.txt)
expected_output='a 2
all 4
application 2
as 2
ascii 2
but 2
characters 2
course 2
file 2
for 2
fun 6
have 4
hello 2
implement 2
in 2
is 2
make 2
most 2
operating 2
project 2
projects 2
sure 2
systems 2
test 2
the 4
to 2
we 2
were 2
wordcount 4'

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
echo "Test2 passed."

exit 0
