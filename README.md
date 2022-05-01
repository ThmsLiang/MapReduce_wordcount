# A MapReduce Implementation of Wordcount Based On C 

## How to compile
The only file needed to compile is `main.c`. To compile, type:
``` gcc -O2 main.c -o main ```

## How to run 
After compiling, type: 
``` ./main <inputfile >outputfile ```
Then you will see the result of wordcount on output file

## About MapReduce in this project
- In this project, there are at default 8 mappers and 2 reducers. 
- Processes communicate with each other via pipes. 
