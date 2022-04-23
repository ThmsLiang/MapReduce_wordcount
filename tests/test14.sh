echo "Running test14..."
echo

out=$(sudo ./main <tests/input14.txt >outputs/output14.txt)
output=$(sort outputs/output14.txt)
expected_output='test 1'

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
echo "Test14 passed."

exit 0
