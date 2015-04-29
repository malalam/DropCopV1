#Team B12

all: server

server: DropCopServer.cpp
	g++ -o server DropCopServer.cpp -lPocoNet -lPocoUtil -LPocoXML -lPocoFoundation -lpqxx -lpq

clean:
	rm -f server
