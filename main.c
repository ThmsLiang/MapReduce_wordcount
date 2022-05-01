//to compile gcc -O2 main.c -o main
//to run ./main <input.txt >output.txt
#include <ctype.h>
#include <search.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <unistd.h>

#define MAX_UNIQUES 60000
#define N 8
#define M 2

static int master_to_mappers[N][2];
static int reducers_to_master[M][2];
static int mappers_to_reducers[M][2];

typedef struct {
    char* word;
    int count;
} count;

// Comparison function for qsort() ordering by count descending.
int cmp_count(const void* p1, const void* p2) {
    int c1 = ((count*)p1)->count;
    int c2 = ((count*)p2)->count;
    if (c1 == c2) return 0;
    if (c1 < c2) return 1;
    return -1;
}

int mapper(int pipe_index) {
   
   // close unnecessary pipes
    for (int i = 0; i < N; i++) {
        if (i != pipe_index) {
            close(master_to_mappers[i][0]);
        }
        close(master_to_mappers[i][1]);
    }
    for(int i=0; i<M; i++){
        close(reducers_to_master[i][1]);
        close(reducers_to_master[i][0]);
        close(mappers_to_reducers[i][0]);
    }

    count* words = calloc(MAX_UNIQUES, sizeof(count));
    int num_words = 0;

    // Allocate hash table.
    if (hcreate(MAX_UNIQUES) == 0) {
        fprintf(stderr, "error creating hash table\n");
        return 1;
    }

    char word[101], letter[1];
    int r_status, w_status;
    int curr_index;
    /************************* READ ************************/
    while ((r_status = read(master_to_mappers[pipe_index][0], letter, 1)) > 0) {
        curr_index = 0;
        while (*letter != '\0') {
            
            word[curr_index++] = *letter;
            r_status = read(master_to_mappers[pipe_index][0],letter, 1);
        }
        word[curr_index] = '\0';

        // Search for word in hash table.
        ENTRY item = {word, NULL};
        ENTRY* found = hsearch(item, FIND);
        if (found != NULL) {
            // Word already in table, increment count.
            int* pn = (int*)found->data;
            (*pn)++;
        } else {
            // Word not in table, insert it with count 1.
            item.key = strdup(word); // need to copy word
            if (item.key == NULL) {
                fprintf(stderr, "out of memory in strdup\n");
                return 1;
            }
            int* pn = malloc(sizeof(int));
            if (pn == NULL) {
                fprintf(stderr, "out of memory in malloc\n");
                return 1;
            }
            *pn = 1;
            item.data = pn;
            ENTRY* entered = hsearch(item, ENTER);
            if (entered == NULL) {
                fprintf(stderr, "table full, increase MAX_UNIQUES\n");
                return 1;
            }
            // And add to words list for iterating.
            words[num_words].word = item.key;
            num_words++;
        }
    }

    close(master_to_mappers[pipe_index][0]);
/************************** END READING *************************/

    for (int i = 0; i < num_words; i++) {
        int target_index = 0;
        if (words[i].word[0] > 'm') {
            target_index = 1;
        }
        
        ENTRY item = {words[i].word, NULL};
        ENTRY* found = hsearch(item, FIND);
        if (found == NULL) { // shouldn't happen
            fprintf(stderr, "key not found: %s\n", item.key);
            return 1;
        }
        words[i].count = *(int*)found->data;
        w_status = write(mappers_to_reducers[target_index][1], words[i].word, strlen(words[i].word) + 1);
        w_status = write(mappers_to_reducers[target_index][1], &(words[i].count), sizeof(words[i].count));
    }
    

    close(mappers_to_reducers[0][1]);
    close(mappers_to_reducers[1][1]);

    hdestroy();
    return 0;
}

int reducer(int pipe_index) {
    // close unnecesssary pipes
    for (int i = 0; i < N; i++) {
        close(master_to_mappers[i][0]);
        close(master_to_mappers[i][1]);
    }
    
    for(int i = 0; i<M; i++){
        close(mappers_to_reducers[i][1]);
    }

    count* words = calloc(MAX_UNIQUES, sizeof(count));
    int num_words = 0;

    // Allocate hash table.
    if (hcreate(MAX_UNIQUES) == 0) {
        fprintf(stderr, "error creating hash table\n");
        return 1;
    }
    char word[101], letter[1];
    int r_status, w_status;
    int curr_index;

    while ((r_status = read(mappers_to_reducers[pipe_index][0], letter, 1)) > 0) {       
        curr_index = 0;
        while (*letter != '\0') {
            word[curr_index++] = *letter;
            r_status = read(mappers_to_reducers[pipe_index][0], letter, 1);
        }
        
        word[curr_index] = '\0';
        
        int num_word; 
        r_status = read(mappers_to_reducers[pipe_index][0], &num_word, sizeof(num_word));

        // Search for word in hash table.
        ENTRY item = {word, NULL};
        ENTRY* found = hsearch(item, FIND);
        if (found != NULL) {
            // Word already in table, increment count.
            int* pn = (int*)found->data;
            (*pn) += num_word;
        } else {
            // Word not in table, insert it with count 1.
            item.key = strdup(word); // need to copy word
            if (item.key == NULL) {
                fprintf(stderr, "out of memory in strdup\n");
                return 1;
            }
            int* pn = malloc(sizeof(int));
            if (pn == NULL) {
                fprintf(stderr, "out of memory in malloc\n");
                return 1;
            }
            *pn = num_word;
            item.data = pn;
            ENTRY* entered = hsearch(item, ENTER);
            if (entered == NULL) {
                fprintf(stderr, "table full, increase MAX_UNIQUES\n");
                return 1;
            }
            words[num_words].word = item.key;
            num_words++;
        }
    }

    // Iterate once to add counts to words list, then sort.
    for (int i = 0; i < num_words; i++) {
        ENTRY item = {words[i].word, NULL};
        ENTRY* found = hsearch(item, FIND);
        if (found == NULL) { // shouldn't happen
            fprintf(stderr, "key not found: %s\n", item.key);
            return 1;
        }
        words[i].count = *(int*)found->data;
    }
    qsort(&words[0], num_words, sizeof(count), cmp_count); 

    for (int i = 0; i < num_words; i++) {
        // printf("%s %d\n", words[i].word, words[i].count);
        w_status = write(reducers_to_master[pipe_index][1], words[i].word, strlen(words[i].word) + 1);
        w_status = write(reducers_to_master[pipe_index][1], &words[i].count, sizeof(words[i].count));
        
    }

    close(reducers_to_master[pipe_index][1]);
    hdestroy();
    return 0;
}


int main() {
    // create pipes
    for (int i = 0; i < N; i++) {
        if (pipe(master_to_mappers[i]) < 0) {
            fprintf(stderr, "Error in creating m2m pipes\n");
        }
    }
    for (int i = 0; i < 2; i++) {
        if (pipe(reducers_to_master[i]) < 0) {
            fprintf(stderr, "Error in creating r2m pipes\n");
        }
        if (pipe(mappers_to_reducers[i]) < 0) {
            fprintf(stderr, "Error in creating m2r pipes\n");
        }
    }

    // fork N+M times
    for (int i = 0; i < N; i++) {
        if (!fork()) {
            return mapper(i);
        }
    }
    for (int i = 0; i < 2; i++) {
        if (!fork()) {
            // printf("reducer\n");
            return reducer(i);
        }
    }

    // close unnecessary pipes
    for (int i = 0; i < N; i++) {
        close(master_to_mappers[i][0]);
    }

    count* words = calloc(MAX_UNIQUES, sizeof(count));
    int num_words = 0;

    // Allocate hash table.
    if (hcreate(MAX_UNIQUES) == 0) {
        fprintf(stderr, "error creating hash table\n");
        return 1;
    }
    
    close(mappers_to_reducers[0][1]);
    close(mappers_to_reducers[1][1]);
    close(reducers_to_master[0][1]);
    close(reducers_to_master[1][1]);

    char word[101], letter[1];   // 100-char word plus NUL byte
    int  r_status, w_status;
    int  curr_index;

    int current_mapper_pipe = 0;
   
    while (scanf("%100s", word) != EOF) {
        char filtered_word[101];
        char* f_p = filtered_word;
        for (char* p = word; *p; p++) {
            *p = tolower(*p);
            // printf("%s", p);
            if (isalpha(*p) || isdigit(*p)) {
                *f_p = *p;
                f_p++;
            }
        }
        *f_p = '\0';
        if (filtered_word[0] == '\0') {
            continue;
        }

        w_status = write(master_to_mappers[current_mapper_pipe][1], filtered_word, strlen(filtered_word) + 1);
        current_mapper_pipe++;
        if(current_mapper_pipe == N){current_mapper_pipe=0;}
    }

    for (int i = 0; i < N; i++) {
        close(master_to_mappers[i][1]);
    }
    
    for (int pipe_index = 0; pipe_index < 2; pipe_index++) {
        while ((r_status = read(reducers_to_master[pipe_index][0], letter, 1)) > 0) {
            curr_index = 0;
            while (*letter != '\0') {
                word[curr_index++] = *letter;
                r_status = read(reducers_to_master[pipe_index][0],letter, 1);
            }
            word[curr_index] = '\0';
            int num_word; 
            r_status = read(reducers_to_master[pipe_index][0], &num_word, sizeof(num_word));

            printf("%s %d\n", word, num_word);
        }
    }
    hdestroy();
    return 0;
}