echo "Running test20..."
echo

out=$(sudo ./main <tests/input20.txt >outputs/output20.txt)
output=$(sort outputs/output20.txt)
expected_output='all 2
and 2
because 1
but 1
cruel 1
good 2
hypocrites 3
i 2
id 1
morning 2
my 1
of 2
patients 1
phony 1
say 1
the 5
thou 1
to 2
very 1
was 2
worse 1
worst 1
ye 1'

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
echo "Test20 passed."

exit 0
