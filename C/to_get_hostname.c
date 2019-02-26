#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/utsname.h>
#include <netdb.h>


void main() {
        char hostname[1024];
        gethostname(hostname,1024);

        struct addrinfo hints={0};
        hints.ai_family=AF_UNSPEC;
        hints.ai_flags=AI_CANONNAME;

        struct addrinfo* res=0;
        if (getaddrinfo(hostname,0,&hints,&res)==0) {
            // The hostname was successfully resolved.
            printf("%s\n",res->ai_canonname);
            freeaddrinfo(res);
        }
        else {
            // Not resolved, so fall back to hostname returned by OS.
            printf("%s\n",hostname);
        }

}
