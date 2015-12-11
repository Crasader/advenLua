--首先载入数据
--然后加载工厂
--然后加载管理者

require "app.Data.LoadingData"
--载入常量
require "app.const"
--载入事件用常量
require "app.EventConst"
--加载敌人出现的速度
require "app.Data.ArmySpeed"
--加载关卡设置
require "app.Data.World1"
--加载敌人配置
require "app.Data.NormalArmyData"

--载入常用函数
require "app.GameFuc"
--载入常用的UI函数
require "app.UIFunc"
--载入地图关卡用的函数
require "app.LevelFuc"

--加载敌人生产工厂
require("app.models.ArmyFactory")

require("app.models.LevelFactory")

require("app.models.EffectFactory")

--载入创建UI所用的管理者
require "app.models.UIManager"

--载入创建场景所用的管理者
require "app.models.SceneManager"

--载入物理世界的管理者
require "app.models.PhysicsManager"

--载入保存数据的管理者
require "app.models.DataManager"

--载入创建角色的管理者
require "app.models.MainRoleManager"

--载入Panel的管理者
require "app.models.PanelManager"

--载入音乐管理者
require "app.models.AudioManager"
--载入对象管理者
require "app.models.ObjectManager"
--载入玩家数据管理者
require "app.models.UserDataManager"

