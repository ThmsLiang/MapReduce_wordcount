echo "Running test18..."
echo

out=$(sudo ./main <tests/input18.txt >outputs/output18.txt)
output=$(sort outputs/output18.txt)
expected_output='address 2
get 1
httpcheckipdyndnsorg 1
import 2
in 1
ip 2
is 1
open 1
order 1
print 3
re 1
refindallrd13d13d13d13 1
request 2
theip 2
this 1
to 2
try 1
url 3
urllib 1
urlliburlopenurlread 1
we 1
will 1
your 1'

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
echo "Test18 passed."

exit 0
