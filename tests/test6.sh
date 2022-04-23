echo "Running test6..."
echo

out=$(sudo ./main <tests/input6.txt >outputs/output6.txt)
output=$(sort outputs/output6.txt)
expected_output='a 1
and 5
another 1
art 2
bareness 1
be 5
beauty 2
beautys 2
bereft 1
breed 1
but 2
checked 1
confounds 1
conquest 1
could 1
death 1
deaths 1
deface 1
depart 1
did 1
distillation 1
distilled 2
do 1
doth 2
dwell 1
effect 1
ere 2
every 2
excel 1
eye 1
fair 1
fairly 1
flowers 1
for 4
forbidden 1
frame 1
frost 1
gaze 1
gentle 1
glass 1
gone 1
hand 1
happier 2
happies 1
heir 1
hideous 1
him 1
hours 1
if 2
in 3
is 1
it 4
leads 1
leaves 1
leaving 1
leese 1
left 1
let 1
liquid 1
lives 1
living 1
loan 1
lovely 1
lusty 1
make 2
meet 1
much 1
neverresting 1
no 1
nor 2
not 4
oersnowed 1
of 2
on 1
one 1
or 1
pay 1
pent 1
place 1
play 1
posterity 1
prisoner 1
quite 1
ragged 1
refigured 1
remembrance 1
same 1
sap 1
self 2
selfkilled 1
selfwilled 1
shouldst 1
show 1
some 2
still 1
substance 1
summer 2
summers 1
sweet 2
ten 5
than 1
that 4
thats 1
the 4
thee 4
their 2
then 3
there 1
they 1
thine 2
those 2
thou 5
though 1
thy 3
time 1
times 3
to 4
too 1
treasure 2
tyrants 1
unfair 1
use 1
usury 1
very 1
vial 1
walls 1
was 1
were 3
what 2
where 2
which 2
will 1
willing 1
winter 2
winters 1
with 5
work 1
worms 1'

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
echo "Test6 passed."

exit 0
