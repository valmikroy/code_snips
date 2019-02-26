#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/utsname.h>
#include <netdb.h>

char hostname[1024];

void get_hostname(){
	gethostname(hostname,1024);
	struct addrinfo hints={0};
	struct addrinfo* res=0;
	hints.ai_family=AF_UNSPEC;
	hints.ai_flags=AI_CANONNAME;

	if (getaddrinfo(hostname,0,&hints,&res)==0) {
			strcpy(hostname,res->ai_canonname);
	    freeaddrinfo(res);
	}

}

int main() {
	get_hostname();
  printf("%s\n",hostname);
}
