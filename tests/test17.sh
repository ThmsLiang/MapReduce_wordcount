echo "Running test17..."
echo

out=$(sudo ./main <tests/input17.txt >outputs/output17.txt)
output=$(sort outputs/output17.txt)
expected_output='a 1
args 1
arraylistmapkeyset 1
arraylistmapvalues 1
b 1
c 1
class 1
d 1
e 1
hashmap 1
import 1
javautil 1
keylist 2
list 2
listinteger 1
liststring 1
mainstring 1
map 1
mapinteger 1
maplist 1
mapput1 1
mapput2 1
mapput3 1
mapput4 1
mapput5 1
new 3
public 2
static 1
string 1
systemoutprintlnkey 1
systemoutprintlnvalue 1
valuelist 2
void 1'

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
echo "Test17 passed."

exit 0
