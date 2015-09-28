var WebSocketServer = require('ws').Server;

var wss = new WebSocketServer({port: 3000});

console.log('Server on port 3000.');

wss.on('connection', function(ws){
	//send message to Client
	ws.send('Hello Cocos2d-x Lua');
	
	//register to receive message
	ws.on('message', function(data){
		console.log(data)
		if (data == "hello") {
			ws.send('fine');
		}
		else {
			ws.send('hi sadi');
		};
		
	});
});