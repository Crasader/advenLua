var WebSocketServer = require('ws').Server;

var wss = new WebSocketServer({port: 4000});

var fs = require('fs');

console.log('Server on port 3000.');

var fs = require('fs');

//创建一个对象构造器来构建一个人物对象
function Person (id) {
	this.id = id;
}

var people = new Array();
var numOfConnect = 0;


wss.on('connection', function(ws){
	//每次连接加1
	numOfConnect = numOfConnect + 1;
	people[numOfConnect] = new Person(numOfConnect);
	console.log(people[numOfConnect].id);
	//register to receive message
	ws.on('message', function(data)
	{
		console.log(data);
		wss.clients.forEach(function each (client) 
		{
			//广播数据
			client.send(data);
		});
	});
});

wss.on('close', function  () {
	console.log("close");
	people[numOfConnect] = null;
	numOfConnect = numOfConnect - 1;
});