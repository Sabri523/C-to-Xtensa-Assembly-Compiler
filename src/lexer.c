#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <stdlib.h>

int is_empty_line(const char *line) {
    while (*line) {
        if (!isspace((unsigned char)*line)) {
            return 0; // not empty
        }
        line++;
    }
    return 1; // only whitespace
}


int main() {
  FILE *fptr;

  // Open a file in read mode
  fptr = fopen("blink.txt", "r");

  // Store the content of the file
  char myString[100];

  // Read the content and print it
  while(fgets(myString, 100, fptr)) {
    if (is_empty_line(myString)) {
        continue;
    }
    else {
        //myString[strcspn(myString, ":")+1] = '\0';
        myString[strcspn(myString, "#")] = '\0';
        printf("%s", myString);
    }
  }

  // Close the file
  fclose(fptr);

  return 0;
}

