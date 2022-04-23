echo "Running test16..."
echo

out=$(sudo ./main <tests/input16.txt >outputs/output16.txt)
output=$(sort outputs/output16.txt)
expected_output='a 6
ac 8
accumsan 3
adipiscing 1
aenean 1
aliquam 2
aliquet 3
amet 3
ante 6
arcu 3
at 2
auctor 3
augue 4
bibendum 2
blandit 4
commodo 2
condimentum 3
congue 1
consectetur 4
consequat 3
convallis 1
cras 2
cubilia 1
curabitur 2
curae 1
cursus 2
dapibus 5
diam 1
dignissim 2
dolor 5
donec 6
dui 1
duis 1
efficitur 2
egestas 2
eget 2
elementum 3
elit 4
enim 4
erat 4
eros 7
est 2
et 13
etiam 2
eu 3
euismod 4
ex 4
facilisis 2
fames 2
faucibus 5
felis 2
fermentum 4
feugiat 2
finibus 3
fringilla 1
fusce 1
gravida 1
hendrerit 3
iaculis 3
id 2
imperdiet 1
in 12
interdum 4
ipsum 5
lacinia 2
lacus 4
laoreet 4
lectus 1
leo 3
libero 1
ligula 3
lobortis 4
lorem 2
luctus 2
maecenas 3
malesuada 2
massa 4
mattis 3
mauris 4
maximus 4
metus 4
mi 2
molestie 1
mollis 2
morbi 3
nam 1
nec 5
neque 2
nibh 5
nisi 1
nisl 3
non 7
nulla 3
nullam 3
nunc 4
odio 3
orci 1
ornare 3
pellentesque 6
pharetra 3
phasellus 1
placerat 2
porta 1
porttitor 3
posuere 5
praesent 1
pretium 2
primis 3
proin 1
pulvinar 2
purus 3
quam 2
quis 5
quisque 1
rhoncus 1
risus 4
rutrum 2
sapien 6
scelerisque 1
sed 9
semper 1
sit 3
sodales 3
sollicitudin 2
suscipit 3
suspendisse 2
tellus 3
tincidunt 7
tortor 4
turpis 1
ultrices 1
urna 6
ut 7
varius 4
vehicula 4
vel 7
venenatis 2
vestibulum 2
vitae 6
vivamus 1
viverra 1
volutpat 4'

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
echo "Test16 passed."

exit 0
