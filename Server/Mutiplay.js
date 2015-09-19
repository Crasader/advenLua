var WebSocketServer = require('ws').Server;

var wss = new WebSocketServer({port: 3000});

var fs = require('fs');

console.log('Server on port 3000.');

var fs = require('fs');

wss.on('connection', function(ws){

	//register to receive message
	ws.on('message', function(data){
			console.log(data);
			wss.clients.forEach(function each (client) {
				//广播数据
				client.send(data);
			})
		});
	});
});