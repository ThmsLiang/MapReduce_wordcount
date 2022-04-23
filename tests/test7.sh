echo "Running test7..."
echo

out=$(sudo ./main <tests/input7.txt >outputs/output7.txt)
output=$(sort outputs/output7.txt)
expected_output='a 1
adore 1
age 2
all 1
and 4
annoy 1
another 2
are 1
attending 1
bear 1
beauty 1
being 1
burning 1
but 2
by 2
car 1
chide 1
child 1
climbed 1
concord 1
confounds 1
converted 1
day 1
delights 1
diest 1
do 3
doth 1
duteous 1
each 3
ear 1
else 1
eye 1
eyes 1
feeble 1
fore 1
from 3
get 1
gladly 1
golden 1
gracious 1
happy 1
having 1
he 1
head 1
hear 1
hearst 1
heavenly 1
highmost 1
hill 1
his 7
homage 1
how 1
husband 1
if 1
in 7
joy 2
lifts 1
light 1
like 1
lo 1
look 1
looks 2
lovst 1
low 1
majesty 1
many 1
mark 1
married 1
middle 1
mortal 1
mother 1
music 2
mutual 1
newappearing 1
none 1
noon 1
not 2
note 1
now 1
of 1
offend 1
on 2
one 4
or 1
ordering 1
orient 1
outgoing 1
parts 1
pilgrimage 1
pitch 1
pleasing 1
pleasure 1
prove 1
receivst 2
reeleth 1
resembling 2
sacred 1
sadly 1
seeming 1
self 1
serving 1
shouldst 1
sight 1
sing 1
single 1
singleness 1
sings 1
sire 1
so 1
son 1
song 1
sounds 1
speechless 1
steepup 1
still 1
strikes 1
string 1
strong 1
sweet 1
sweetly 1
sweets 2
that 2
the 7
thee 2
they 1
thine 2
this 1
thou 7
thy 2
to 4
tract 1
true 1
under 1
unions 1
unless 1
unlooked 1
up 1
war 1
way 1
weary 1
welltuned 1
when 2
which 1
who 2
whose 1
why 2
wilt 1
with 4
yet 1
youth 1'

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
echo "Test7 passed."

exit 0
