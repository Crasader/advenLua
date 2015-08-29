#include "lua_my_class_auto.hpp"
#include "Game/Hero.h"
#include "Game/Army001.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"


int lua_my_class_Hero_setAllEvent(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_setAllEvent'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_setAllEvent'", nullptr);
            return 0;
        }
        cobj->setAllEvent();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:setAllEvent",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_setAllEvent'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_getState(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_getState'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_getState'", nullptr);
            return 0;
        }
        int ret = cobj->getState();
        tolua_pushnumber(tolua_S,(lua_Number)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:getState",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_getState'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_Idle(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_Idle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_Idle'", nullptr);
            return 0;
        }
        cobj->Idle();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:Idle",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_Idle'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_Walk(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_Walk'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_Walk'", nullptr);
            return 0;
        }
        cobj->Walk();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:Walk",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_Walk'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_Jump(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_Jump'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_Jump'", nullptr);
            return 0;
        }
        cobj->Jump();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:Jump",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_Jump'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_init(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_init'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_init'", nullptr);
            return 0;
        }
        bool ret = cobj->init();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:init",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_init'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_Attack(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Hero*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Hero_Attack'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_Attack'", nullptr);
            return 0;
        }
        cobj->Attack();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:Attack",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_Attack'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Hero_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"Hero",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_create'", nullptr);
            return 0;
        }
        Hero* ret = Hero::create();
        object_to_luaval<Hero>(tolua_S, "Hero",(Hero*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "Hero:create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_create'.",&tolua_err);
#endif
    return 0;
}
int lua_my_class_Hero_constructor(lua_State* tolua_S)
{
    int argc = 0;
    Hero* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif



    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Hero_constructor'", nullptr);
            return 0;
        }
        cobj = new Hero();
        cobj->autorelease();
        int ID =  (int)cobj->_ID ;
        int* luaID =  &cobj->_luaID ;
        toluafix_pushusertype_ccobject(tolua_S, ID, luaID, (void*)cobj,"Hero");
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Hero:Hero",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Hero_constructor'.",&tolua_err);
#endif

    return 0;
}

static int lua_my_class_Hero_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Hero)");
    return 0;
}

int lua_register_my_class_Hero(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"Hero");
    tolua_cclass(tolua_S,"Hero","Hero","sp.SkeletonAnimation",nullptr);

    tolua_beginmodule(tolua_S,"Hero");
        tolua_function(tolua_S,"new",lua_my_class_Hero_constructor);
        tolua_function(tolua_S,"setAllEvent",lua_my_class_Hero_setAllEvent);
        tolua_function(tolua_S,"getState",lua_my_class_Hero_getState);
        tolua_function(tolua_S,"Idle",lua_my_class_Hero_Idle);
        tolua_function(tolua_S,"Walk",lua_my_class_Hero_Walk);
        tolua_function(tolua_S,"Jump",lua_my_class_Hero_Jump);
        tolua_function(tolua_S,"init",lua_my_class_Hero_init);
        tolua_function(tolua_S,"Attack",lua_my_class_Hero_Attack);
        tolua_function(tolua_S,"create", lua_my_class_Hero_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(Hero).name();
    g_luaType[typeName] = "Hero";
    g_typeCast["Hero"] = "Hero";
    return 1;
}

int lua_my_class_Army001_init(lua_State* tolua_S)
{
    int argc = 0;
    Army001* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Army001",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Army001*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Army001_init'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Army001_init'", nullptr);
            return 0;
        }
        bool ret = cobj->init();
        tolua_pushboolean(tolua_S,(bool)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Army001:init",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Army001_init'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Army001_getBody(lua_State* tolua_S)
{
    int argc = 0;
    Army001* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Army001",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Army001*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Army001_getBody'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Army001_getBody'", nullptr);
            return 0;
        }
        cocos2d::Node* ret = cobj->getBody();
        object_to_luaval<cocos2d::Node>(tolua_S, "cc.Node",(cocos2d::Node*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Army001:getBody",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Army001_getBody'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Army001_Idle(lua_State* tolua_S)
{
    int argc = 0;
    Army001* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Army001",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Army001*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Army001_Idle'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Army001_Idle'", nullptr);
            return 0;
        }
        cobj->Idle();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Army001:Idle",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Army001_Idle'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Army001_Walk(lua_State* tolua_S)
{
    int argc = 0;
    Army001* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"Army001",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (Army001*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_my_class_Army001_Walk'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 0) 
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Army001_Walk'", nullptr);
            return 0;
        }
        cobj->Walk();
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "Army001:Walk",argc, 0);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Army001_Walk'.",&tolua_err);
#endif

    return 0;
}
int lua_my_class_Army001_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"Army001",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_my_class_Army001_create'", nullptr);
            return 0;
        }
        Army001* ret = Army001::create();
        object_to_luaval<Army001>(tolua_S, "Army001",(Army001*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "Army001:create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_my_class_Army001_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_my_class_Army001_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (Army001)");
    return 0;
}

int lua_register_my_class_Army001(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"Army001");
    tolua_cclass(tolua_S,"Army001","Army001","cc.Node",nullptr);

    tolua_beginmodule(tolua_S,"Army001");
        tolua_function(tolua_S,"init",lua_my_class_Army001_init);
        tolua_function(tolua_S,"getBody",lua_my_class_Army001_getBody);
        tolua_function(tolua_S,"Idle",lua_my_class_Army001_Idle);
        tolua_function(tolua_S,"Walk",lua_my_class_Army001_Walk);
        tolua_function(tolua_S,"create", lua_my_class_Army001_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(Army001).name();
    g_luaType[typeName] = "Army001";
    g_typeCast["Army001"] = "Army001";
    return 1;
}
TOLUA_API int register_all_my_class(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_my_class_Hero(tolua_S);
	lua_register_my_class_Army001(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

