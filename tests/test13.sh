echo "Running test13..."
echo

out=$(sudo ./main <tests/input13.txt >outputs/output13.txt)
output=$(sort outputs/output13.txt)
expected_output='a 238'

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
echo "Test13 passed."

exit 0
