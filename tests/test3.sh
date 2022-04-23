echo "Running test3..."
echo

out=$(sudo ./main <tests/input3.txt >outputs/output3.txt)
output=$(sort outputs/output3.txt)
expected_output='a 1
abundance 1
and 3
art 1
as 1
be 1
bear 1
beautys 1
bright 1
bud 1
buriest 1
but 2
by 2
churl 1
content 1
contracted 1
creatures 1
cruel 1
decease 1
desire 1
die 1
due 1
eat 1
else 1
eyes 1
fairest 1
famine 1
feedst 1
flame 1
foe 1
fresh 1
from 1
fuel 1
gaudy 1
glutton 1
grave 1
heir 1
herald 1
his 2
in 1
increase 1
lies 1
lights 1
making 1
makst 1
memory 1
might 2
never 1
niggarding 1
now 1
only 1
or 1
ornament 1
own 2
pity 1
riper 1
rose 1
self 2
selfsubstantial 1
should 1
spring 1
sweet 1
tender 2
that 2
the 6
thee 1
thereby 1
thine 2
this 1
thou 2
thy 5
time 1
to 4
too 1
waste 1
we 1
where 1
with 1
within 1
world 1
worlds 2'

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
echo "Test3 passed."

exit 0
