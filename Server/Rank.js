var WebSocketServer = require('ws').Server;

var wss = new WebSocketServer({port: 4000});

var fs = require('fs');

console.log('Server on port 4000.');

var fs = require('fs');

//创建一个对象构造器来构建一个人物对象
function Person (name, score) 
{
	this.Name = name;
	this.Score = score;
}

var peopleScore = new Array(600, 500, 400, 300, 200, 100);
var peopleName = new Array("CCC", "BBB", "AAA", "DDD", "EEE", "FFF");

//这个时候读取文件
// var fileStr = fs.readFileSync("./")
str = fs.readFileSync("./ScoreEasy.json");
var ScoreEasy = JSON.parse(str)

str = fs.readFileSync("./ScoreNormal.json");
var ScoreNormal = JSON.parse(str)

star = fs.readFileSync("./ScoreHard.json");
var ScoreHard = JSON.parse(str);

//一个指向成绩的指针
var Score
wss.on('connection', function(ws)
{
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

		function isNeedSort (obj)
		{
			for (var num = 0; num < Score.length; num ++)
			{
				//先判断是不是同一个玩家，如果是就比较其分数有没超越，没有就返回
				if (Score[num].Name == obj.Name )
				{
					if(Score[num].Score <= obj.Score)
					{
						Score[num] = obj;
						return true;
					}
					else
					{
						return false;
					}
				}
			}

			if ( obj.Score >= Score[4].Score )
			{
				Score[4] = obj;
				return true;
			}
			return false;
		}

		function sortAll ( obj) 
		{

			
			//在进行排序
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
		//data的格式是000x{json}，前面四个是难度值
		var gameStr = data.slice(4,data.length)

		//获得难度值
		var diffculty = parseInt(data.slice(3,4))
		console.log("diffculty is :");
		console.log(diffculty);
		//根据难度让Score指针指向不同的数组
		switch(diffculty)
		{

			case 1 :
				Score = ScoreEasy;
				break;
			case 2 :
				Score = ScoreNormal;
				break;
			case 3 :
				Score = ScoreHard;
				break;
			default:
				Score = ScoreEasy;
				break;
		}
		var GameScore = JSON.parse(gameStr);
		
		var needSort = isNeedSort(GameScore);
		//是新的才进行排序,而且分数比较高的
		sortAll(GameScore);
		
		//否则可能是老的，但是分数可能比较高的
		//根据难度选择解析的时间
		str = JSON.stringify(Score);

		ws.send(str);

		//保存数据
		//根据难度保存数据
		switch(diffculty)
		{

			case 1 :
				fs.writeFileSync("./ScoreEasy.json", str);
				break;
			case 2 :
				fs.writeFileSync("./ScoreNormal.json", str);

				break;
			case 3 :
				fs.writeFileSync("./ScoreHard.json", str);

				break;
			default:
				break;
		}

	});
});
