echo "Running test4..."
echo

out=$(sudo ./main <tests/input4.txt >outputs/output4.txt)
output=$(sort outputs/output4.txt)
expected_output='a 1
all 2
alleating 1
an 1
and 4
answer 1
art 1
asked 1
be 2
beauty 2
beautys 2
being 1
besiege 1
blood 1
brow 1
by 1
child 1
cold 1
couldst 1
count 1
days 1
deep 2
deservd 1
dig 1
excuse 1
eyes 1
fair 1
feelst 1
field 1
forty 1
gazed 1
held 1
his 1
how 1
if 1
in 1
it 1
lies 1
livery 1
lusty 1
made 1
make 1
mine 1
more 1
much 1
my 2
new 1
now 1
of 3
old 2
on 1
own 1
praise 2
proud 1
proving 1
say 1
see 1
shall 2
shame 1
small 1
so 1
succession 1
sum 1
sunken 1
tattered 1
the 1
then 1
thine 2
this 2
thou 3
thriftless 1
thy 7
to 2
treasure 1
trenches 1
use 1
warm 1
weed 1
were 2
when 3
where 2
will 1
winters 1
within 1
worth 1
youths 1'

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
echo "Test4 passed."

exit 0
