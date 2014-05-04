#include<iostream>
#include<cstring>
#include<cstdio>
using namespace std;

#define BSIZE 80

void printUsage(void){

  fprintf(stderr,"\n\nUsage: \t produce <infilename> <rulefilename> <outputfilename> \n\n");
  fprintf(stderr,"\t\t Rename <infilename> to <outfilename> and appends <rulefilename>\n");
  fprintf(stderr,"\t\t contents to it \n\n\n");

}

append(FILE *out, FILE *rule)
{
    char buffer[BSIZE+1];
    size_t n;

    while ((n = fread(buffer, 1, sizeof buffer, tail)) > 0)
        if (fwrite(buffer, 1, n, head) != n)
            abort();

    if (ferror(tail))
        abort();
}

int produce(char ofilename[], char rfilename[])
{
  FILE *out = fopen("ofilename", "ab");
  FILE *rule = fopen("rfilename", "rb");
    if (!head || !tail)
        abort();
    append(head, tail);


  if (fopen()

  return 1;
}

int main(int argc, char* argv[] ){

  char ifilename[200];
  char rfilename[200];
  char ofilename[200];

  if(argc != 4)
  {
    printUsage();
    return 0;
  }
  
  // 1st input filename 
  // 2nd rule filename
  // 3rd output filename 
  
  sprintf(ifilename,"%s",argv[1]);
  sprintf(rfilename,"%s",argv[2]);
  sprintf(ofilename,"%s",argv[3]);

  // rename file
  if(rename(ifilename,ofilename)==-1)
  {
    fprintf(stderr,"couldnt rename file %s",ifilename);
    return 0;
  }

  return produce(ofilename, rfilename); 
  
}
