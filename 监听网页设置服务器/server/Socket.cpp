#include "Socket.h"

/*		TCPSocket的实现		*/
TCPSocket::TCPSocket()
{
	create();
}

TCPSocket::~TCPSocket()
{
	close();
}
bool TCPSocket::create()
{
	m_sockfd = socket(AF_INET,SOCK_STREAM,0);
	if(this->m_sockfd == -1)
	{
		printf("Socket error\n");
		return false;
	}
	return true;
}

bool TCPSocket::bind(unsigned short int port, const char *ip )
{
	bzero(&server_addr,sizeof(struct sockaddr_in));
	server_addr.sin_family = AF_INET;
	if(ip==NULL)
		server_addr.sin_addr.s_addr = INADDR_ANY;
	else
		server_addr.sin_addr.s_addr = inet_addr(ip);
	
	server_addr.sin_port = htons(port);
	if(::bind(this->m_sockfd,(struct sockaddr *)(&server_addr),sizeof(struct sockaddr)) == -1)
	{
		printf("Bind error\n\a");
		return false;
	}
	return true;
}

bool TCPSocket::reuseaddr()
{
	bool iSockopt = true;
	if(setsockopt(this->m_sockfd,SOL_SOCKET,SO_REUSEADDR,(const char *)&iSockopt,sizeof(int))< 0 )
	{
		close();
		return false;
	}
	return true;
}

bool TCPSocket::setNonBlocking(bool flag)  //flag: true=SetNonBlock, false=SetBlock;
{
	return true;
}
int  TCPSocket::getfd()
{
	return this->m_sockfd;
}
bool TCPSocket::isValid()
{
	if(this->m_sockfd >2)
		return true;
	return false;
}
bool TCPSocket::close()
{
	if(::close(this->m_sockfd)==0)
		return true;
	return false;
}
    
    /**注意: TCPSocket基类并没有send/receive方法**/
int TCPSocket::read(void *buf, int count)
{
	memset(buf,0,count);
	return ::read(this->m_sockfd,buf,count);
}
int TCPSocket::write(const void *buf, int count)
{	
	return ::write(this->m_sockfd,buf,count);
}
int TCPSocket::readn(int fd, void *buf, int count)
{
	memset(buf,0,sizeof(buf));
	int bytes=0;
	while(bytes<count)
		bytes += ::read(fd,buf,count);	
	return bytes;
}	
int TCPSocket::writen(int fd, const void *buf, int count)
{
	int bytes=0;
	while(bytes<count)
		bytes += ::write(fd,buf,count);	
	return bytes;
}


/** --------------派生类TCP Client ----------------**/

TCPClient::TCPClient(unsigned short int port, const char *ip)
{
	if(create())
	{
		bzero(&client_addr,sizeof(struct sockaddr_in));
		client_addr.sin_family = AF_INET;
		if(ip==NULL)
			client_addr.sin_addr.s_addr = INADDR_ANY;
		else
			client_addr.sin_addr.s_addr = inet_addr(ip);
		
		client_addr.sin_port = htons(port);
		if(::bind(this->m_sockfd,(struct sockaddr *)(&client_addr),sizeof(struct sockaddr)) == -1)
		{
			printf("Bind error\n\a");
		}
	}
}
	
TCPClient::TCPClient()
{
 	create();
}
 
TCPClient::TCPClient(int clientfd)
{
 	this->m_sockfd=clientfd;
}
TCPClient::~TCPClient()
{
 	close();
}

bool  TCPClient::connect(unsigned short int port, const char *ip)
{
	bzero(&server_addr,sizeof(server_addr)); 
	server_addr.sin_family=AF_INET;          
	server_addr.sin_port=htons(port);    
	//server_addr.sin_addr=*((struct in_addr *)host->h_addr); 
	server_addr.sin_addr.s_addr = inet_addr(ip);   
	if(::connect(this->m_sockfd,(struct sockaddr *)(&server_addr),sizeof(server_addr))==-1)
	{	 
		printf("Connect Error\a\n");    
		return false; 
	}	
	else
		return false;
	return true;
}


int  TCPClient::send(const std::string & message)
{
	return ::send(this->m_sockfd,message.c_str(),message.length(),0);
}
	
int  TCPClient::receive(std::string & message)/*   有问题    */
{
	int length=-1;
	char recv[MESSAGEMAX];
	memset(recv,0,MESSAGEMAX);
	length=::recv(this->m_sockfd,recv,MESSAGEMAX,0);
	string str(recv);

	message=str;
//	cout<<"length="<<message.length()<<endl;
	return length;	
} 

    
int  TCPClient::read(void *buf, int count)
{
	memset(buf,0,count);
	return ::read(this->m_sockfd,buf,count);
}

void  TCPClient::write(const void *buf, int count)
{
	::write(this->m_sockfd,buf,count);
}
int  TCPClient::write(const char *msg)
{
	return ::write(this->m_sockfd,msg,strlen(msg));
}

/** --------------------派生类 TCP Server ----------------- **/

TCPServer::TCPServer(unsigned short int port, const char *ip, int backlog)
{
	reuseaddr();
	if(create())
	{
		bind(port,ip);
	 	if(listen(backlog)==-1)   
		{    
		 	printf("Listen error\n\a");    
		 }
	}
		
}
TCPServer::TCPServer()
{
	create();		
}

TCPServer::~TCPServer()
{
	close();
}

bool  TCPServer::listen(int backlog)
{
	if(::listen(this->m_sockfd,backlog)==-1)
		return false;
	return true;
}
int  TCPServer::accept()  //返回新建连接的描述符
{
	int client_sockfd=-1;
	socklen_t sin_size=sizeof(struct sockaddr_in);    
	if((client_sockfd=::accept(this->m_sockfd,(struct sockaddr *)(&client_addr),&sin_size))==-1)    
	{	  
		printf("Accept error\n\a");	   
		return -1;
	}
	printf("Server get connection from %s\n",inet_ntoa(client_addr.sin_addr)); // 将网络地址转换成.字符串
	return client_sockfd;	
}
int  TCPServer::send(int fd,const std::string & message)
{	
	return ::send(this->m_sockfd,message.c_str(),message.length(),0);	
}
int  TCPServer::receive(int fd, std::string & message)
{
	int length=-1;
	char recv[MESSAGEMAX];
	memset(recv,0,MESSAGEMAX);
	length=::recv(fd,recv,MESSAGEMAX,0);
	string str(recv);
	
	message=str;
	//cout<<"length="<<message.length()<<endl;
	return length;	
} 


