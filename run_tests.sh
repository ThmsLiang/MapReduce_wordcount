#!/bin/bash

export RED=$(tput setaf 1 :-"" 2>/dev/null)
export GREEN=$(tput setaf 2 :-"" 2>/dev/null)
export RESET=$(tput sgr0 :-"" 2>/dev/null)

grade=0

make
for ((i=1; i<=20; i++))
do
	if [[ ${i} -lt 10 ]]; then
		echo -n "$i. Running test$i..........."
	else
		echo -n "$i. Running test$i........."
	fi
	if bash tests/test$i.sh | grep "Test$i passed." -q; then
		((grade=grade+1))
		echo $GREEN "PASSED" $RESET
	else
		echo $RED "FAILED" $RESET
	fi
done
echo "GRADE: $grade/20"
