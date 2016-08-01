#include "Socket.h"
#include <sys/types.h>
#include <regex.h>

int main()
{
	TCPServer server(8888,"192.168.252.4",5);
	cout<<"server is start..."<<endl;
	//regex_t regex;
	//char mypattern[]="([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,6}";
	char cmd[200];
	//regmatch_t match[4];
	//size_t nmatch = 4;
	char urlpath[]="../urls/seed.txt";
	char shellpath[]="./search.sh";
	while(1)
	{
		int clientsockfd=server.accept();
		//server.send(clientsockfd,"hello client");
		string msg;
		string back="hello client";
		server.receive(clientsockfd,msg);
		cout<<"receive message:"<<msg<<endl;
		//server.send(clientsockfd,back);
		//regcomp(&regex,mypattern,REG_EXTENDED | REG_NEWLINE);

        	int flag = true;//regexec(&regex,msg.c_str(), nmatch,match,0);  
  
        	if (flag)  
            	{
			memset(cmd,0,200);
			sprintf(cmd,"echo '' > %s",urlpath);
			cout<<"cmd:"<<cmd<<endl;
			system(cmd);
			memset(cmd,0,200);
			char urls[200];
			memset(urls,0,200);
			strcpy(urls,msg.c_str());
			int length=strlen(urls);
			cout<<"length = "<<length<<endl;
			urls[length]='\0';
			sprintf(cmd,"echo 'http://%s' > %s ",urls,urlpath);
			cout<<"cmd:"<<cmd<<endl;
			system(cmd);
			//Ö´ÐÐshell½Å±¾
			system(shellpath);
		}
		sleep(1);
	}
	
	return 0;
}

