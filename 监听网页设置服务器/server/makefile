CC=g++ -g -Wall 
src=$(shell find . -name '*.cpp')
obj=$(src:.cpp=.o)
main:$(obj)
	$(CC) $(src) -std=c++11 -o main
clean:
	rm -f main $(obj)

