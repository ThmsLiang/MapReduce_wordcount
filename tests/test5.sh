echo "Running test5..."
echo

out=$(sudo ./main <tests/input5.txt >outputs/output5.txt)
output=$(sort outputs/output5.txt)
expected_output='age 1
and 3
another 1
april 1
art 1
back 1
be 2
beguile 1
but 1
calls 1
despite 1
die 1
dies 1
disdains 1
dost 1
face 2
fair 1
fond 1
for 1
form 1
fresh 1
glass 2
golden 1
he 1
her 1
his 1
husbandry 1
if 2
image 1
in 2
is 3
live 1
look 1
lovely 1
mother 1
mothers 1
not 2
now 2
of 5
or 1
posterity 1
prime 1
remembered 1
renewest 1
repair 1
see 1
selflove 1
shalt 1
she 2
should 1
single 1
so 3
some 1
stop 1
tell 1
that 1
the 6
thee 2
thine 2
this 1
thou 6
through 1
thy 4
tillage 1
time 2
to 2
tomb 1
unbless 1
uneared 1
viewest 1
where 1
who 1
whose 2
will 1
windows 1
with 1
womb 1
world 1
wrinkles 1'

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
echo "Test5 passed."

exit 0
