var WebSocketServer = require('ws').Server;

var wss = new WebSocketServer({port: 4000});

var fs = require('fs');

console.log('Server on port 4000.');

var fs = require('fs');

//创建一个对象构造器来构建一个人物对象
function Person (name, score) {
	this.Name = name;
	this.Score = score;
}

var people = new Array(6);
var Score = new Array(6);

//初始化
for (i = 0; i < people.length; i ++)
{
	var num = (2000 - i)
	console.log(num);
	people[i] = new Person("sadi", num);
	Score[i] = new Person("sadi", 0);
}


var str = JSON.stringify(people)
console.log(str);

wss.on('connection', function(ws){
	//获取数据
	// var str = fs.readFileSync("./Score.json");

	//将数据解析成 对象并赋值
	// var ScoreObject = JSON.parse(str);

	//register to receive message
	ws.on('message', function(data)
	{
		console.log(data);

		//test
		function swap (a, b)
		{
			var temp = new Person(Score[a].Name, Score[a].Score);
			Score[a] = Score[b];
			Score[b] = temp;
		}

		function sortAll ( obj) {
			Score[5] = obj;
			for ( var index = 0; index < 6 ; index ++)
			{
				for (var i = index + 1 ; i < 6 ; i ++)
				{

					if (Score[index].Score <= Score[i].Score)
					{
						swap(index, i);
					}
				}
			}

		}


		//将data解析成对象
		var GameScore = JSON.parse(data)
		
		sortAll(GameScore);
		str = JSON.stringify(Score);
		console.log(str);
	
		ws.send(str);
	});
});
