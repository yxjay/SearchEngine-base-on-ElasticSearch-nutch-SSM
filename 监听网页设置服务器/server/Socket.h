#ifndef SOCKET_H_INCLUDED
#define SOCKET_H_INCLUDED

//#include "commen.h"

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <iostream>
#include <stdio.h>
using namespace std;

#define MESSAGEMAX 1024

/*数据包定义*/
typedef struct _Packet
{
    unsigned int    msgLen;     //数据部分的长度(网络字节序)
    char            text[1024]; //报文的数据部分
}Packet;


/*---------------基类定义----------------*/
class TCPSocket
{
public:
    TCPSocket();
    ~TCPSocket();

    bool create();
    bool bind(unsigned short int port, const char *ip = NULL);
    bool reuseaddr();    
    bool setNonBlocking(bool flag);  //flag: true=SetNonBlock, false=SetBlock;
    int  getfd();
    bool isValid();    
    bool close(); 
    
    /**注意: TCPSocket基类并没有send/receive方法**/
    int read(void *buf, int count);
    int write(const void *buf, int count);
    int readn(int fd, void *buf, int count);
    int writen(int fd, const void *buf, int count);

//protected:
    int m_sockfd;
    struct sockaddr_in server_addr; 
    struct sockaddr_in client_addr; //用于服务器端连接
};


/** --------------派生类TCP Client ----------------**/
class TCPClient : public TCPSocket
{        
public:
    TCPClient(unsigned short int port, const char *ip);
    TCPClient();
    TCPClient(int clientfd);
    ~TCPClient();

    bool connect(unsigned short int port, const char *ip); 
    int send(const std::string &message);
    int receive(std::string &message);

    
    int read(void *buf, int count);
    void write(const void *buf, int count);
    int write(const char *msg);
    
private:

};


/** --------------------派生类 TCP Server ----------------- **/
class TCPServer : public TCPSocket
{
public:
    TCPServer(unsigned short int port, const char *ip = NULL, int backlog = SOMAXCONN);
    TCPServer();
    ~TCPServer(); 

    bool listen(int backlog = SOMAXCONN);
    int accept();  //返回新建连接的描述符
    int send(int fd,const std::string &message);
    int receive(int fd, std::string &message);
    
    TCPSocket m_newSocket;  //保存新的客户端连接描述符
};


#endif // SOCKET_H_INCLUDED

