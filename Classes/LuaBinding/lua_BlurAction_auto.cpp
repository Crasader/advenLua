#include "lua_BlurAction_auto.hpp"
#include "Game/BlurAction.h"
#include "tolua_fix.h"
#include "LuaBasicConversions.h"


int lua_Blur_Action_BoxfilterAct_setShader(lua_State* tolua_S)
{
    int argc = 0;
    BoxfilterAct* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"BoxfilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (BoxfilterAct*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_Blur_Action_BoxfilterAct_setShader'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "BoxfilterAct:setShader");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_setShader'", nullptr);
            return 0;
        }
        cobj->setShader(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "BoxfilterAct:setShader",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_BoxfilterAct_setShader'.",&tolua_err);
#endif

    return 0;
}
int lua_Blur_Action_BoxfilterAct_update(lua_State* tolua_S)
{
    int argc = 0;
    BoxfilterAct* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"BoxfilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (BoxfilterAct*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_Blur_Action_BoxfilterAct_update'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        double arg0;

        ok &= luaval_to_number(tolua_S, 2,&arg0, "BoxfilterAct:update");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_update'", nullptr);
            return 0;
        }
        cobj->update(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "BoxfilterAct:update",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_BoxfilterAct_update'.",&tolua_err);
#endif

    return 0;
}
int lua_Blur_Action_BoxfilterAct_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"BoxfilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 0)
    {
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_create'", nullptr);
            return 0;
        }
        BoxfilterAct* ret = BoxfilterAct::create();
        object_to_luaval<BoxfilterAct>(tolua_S, "BoxfilterAct",(BoxfilterAct*)ret);
        return 1;
    }
    if (argc == 1)
    {
        double arg0;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BoxfilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_create'", nullptr);
            return 0;
        }
        BoxfilterAct* ret = BoxfilterAct::create(arg0);
        object_to_luaval<BoxfilterAct>(tolua_S, "BoxfilterAct",(BoxfilterAct*)ret);
        return 1;
    }
    if (argc == 2)
    {
        double arg0;
        double arg1;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BoxfilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BoxfilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_create'", nullptr);
            return 0;
        }
        BoxfilterAct* ret = BoxfilterAct::create(arg0, arg1);
        object_to_luaval<BoxfilterAct>(tolua_S, "BoxfilterAct",(BoxfilterAct*)ret);
        return 1;
    }
    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BoxfilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BoxfilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BoxfilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_create'", nullptr);
            return 0;
        }
        BoxfilterAct* ret = BoxfilterAct::create(arg0, arg1, arg2);
        object_to_luaval<BoxfilterAct>(tolua_S, "BoxfilterAct",(BoxfilterAct*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BoxfilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BoxfilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BoxfilterAct:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "BoxfilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BoxfilterAct_create'", nullptr);
            return 0;
        }
        BoxfilterAct* ret = BoxfilterAct::create(arg0, arg1, arg2, arg3);
        object_to_luaval<BoxfilterAct>(tolua_S, "BoxfilterAct",(BoxfilterAct*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "BoxfilterAct:create",argc, 0);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_BoxfilterAct_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_BoxfilterAct_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (BoxfilterAct)");
    return 0;
}

int lua_register_Blur_Action_BoxfilterAct(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"BoxfilterAct");
    tolua_cclass(tolua_S,"BoxfilterAct","BoxfilterAct","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"BoxfilterAct");
        tolua_function(tolua_S,"setShader",lua_Blur_Action_BoxfilterAct_setShader);
        tolua_function(tolua_S,"update",lua_Blur_Action_BoxfilterAct_update);
        tolua_function(tolua_S,"create", lua_Blur_Action_BoxfilterAct_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(BoxfilterAct).name();
    g_luaType[typeName] = "BoxfilterAct";
    g_typeCast["BoxfilterAct"] = "BoxfilterAct";
    return 1;
}

int lua_Blur_Action_EdgeFilterAct_setShader(lua_State* tolua_S)
{
    int argc = 0;
    EdgeFilterAct* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"EdgeFilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (EdgeFilterAct*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_Blur_Action_EdgeFilterAct_setShader'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "EdgeFilterAct:setShader");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_EdgeFilterAct_setShader'", nullptr);
            return 0;
        }
        cobj->setShader(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "EdgeFilterAct:setShader",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_EdgeFilterAct_setShader'.",&tolua_err);
#endif

    return 0;
}
int lua_Blur_Action_EdgeFilterAct_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"EdgeFilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "EdgeFilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "EdgeFilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "EdgeFilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_EdgeFilterAct_create'", nullptr);
            return 0;
        }
        EdgeFilterAct* ret = EdgeFilterAct::create(arg0, arg1, arg2);
        object_to_luaval<EdgeFilterAct>(tolua_S, "EdgeFilterAct",(EdgeFilterAct*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "EdgeFilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "EdgeFilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "EdgeFilterAct:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "EdgeFilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_EdgeFilterAct_create'", nullptr);
            return 0;
        }
        EdgeFilterAct* ret = EdgeFilterAct::create(arg0, arg1, arg2, arg3);
        object_to_luaval<EdgeFilterAct>(tolua_S, "EdgeFilterAct",(EdgeFilterAct*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "EdgeFilterAct:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_EdgeFilterAct_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_EdgeFilterAct_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (EdgeFilterAct)");
    return 0;
}

int lua_register_Blur_Action_EdgeFilterAct(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"EdgeFilterAct");
    tolua_cclass(tolua_S,"EdgeFilterAct","EdgeFilterAct","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"EdgeFilterAct");
        tolua_function(tolua_S,"setShader",lua_Blur_Action_EdgeFilterAct_setShader);
        tolua_function(tolua_S,"create", lua_Blur_Action_EdgeFilterAct_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(EdgeFilterAct).name();
    g_luaType[typeName] = "EdgeFilterAct";
    g_typeCast["EdgeFilterAct"] = "EdgeFilterAct";
    return 1;
}

int lua_Blur_Action_SharpFilterAct_setShader(lua_State* tolua_S)
{
    int argc = 0;
    SharpFilterAct* cobj = nullptr;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif


#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertype(tolua_S,1,"SharpFilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    cobj = (SharpFilterAct*)tolua_tousertype(tolua_S,1,0);

#if COCOS2D_DEBUG >= 1
    if (!cobj) 
    {
        tolua_error(tolua_S,"invalid 'cobj' in function 'lua_Blur_Action_SharpFilterAct_setShader'", nullptr);
        return 0;
    }
#endif

    argc = lua_gettop(tolua_S)-1;
    if (argc == 1) 
    {
        std::string arg0;

        ok &= luaval_to_std_string(tolua_S, 2,&arg0, "SharpFilterAct:setShader");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_SharpFilterAct_setShader'", nullptr);
            return 0;
        }
        cobj->setShader(arg0);
        lua_settop(tolua_S, 1);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d \n", "SharpFilterAct:setShader",argc, 1);
    return 0;

#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_SharpFilterAct_setShader'.",&tolua_err);
#endif

    return 0;
}
int lua_Blur_Action_SharpFilterAct_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"SharpFilterAct",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "SharpFilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "SharpFilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "SharpFilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_SharpFilterAct_create'", nullptr);
            return 0;
        }
        SharpFilterAct* ret = SharpFilterAct::create(arg0, arg1, arg2);
        object_to_luaval<SharpFilterAct>(tolua_S, "SharpFilterAct",(SharpFilterAct*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "SharpFilterAct:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "SharpFilterAct:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "SharpFilterAct:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "SharpFilterAct:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_SharpFilterAct_create'", nullptr);
            return 0;
        }
        SharpFilterAct* ret = SharpFilterAct::create(arg0, arg1, arg2, arg3);
        object_to_luaval<SharpFilterAct>(tolua_S, "SharpFilterAct",(SharpFilterAct*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "SharpFilterAct:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_SharpFilterAct_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_SharpFilterAct_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (SharpFilterAct)");
    return 0;
}

int lua_register_Blur_Action_SharpFilterAct(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"SharpFilterAct");
    tolua_cclass(tolua_S,"SharpFilterAct","SharpFilterAct","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"SharpFilterAct");
        tolua_function(tolua_S,"setShader",lua_Blur_Action_SharpFilterAct_setShader);
        tolua_function(tolua_S,"create", lua_Blur_Action_SharpFilterAct_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(SharpFilterAct).name();
    g_luaType[typeName] = "SharpFilterAct";
    g_typeCast["SharpFilterAct"] = "SharpFilterAct";
    return 1;
}

int lua_Blur_Action_BloomUp_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"BloomUp",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BloomUp:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BloomUp:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BloomUp:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BloomUp_create'", nullptr);
            return 0;
        }
        BloomUp* ret = BloomUp::create(arg0, arg1, arg2);
        object_to_luaval<BloomUp>(tolua_S, "BloomUp",(BloomUp*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BloomUp:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BloomUp:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BloomUp:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "BloomUp:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BloomUp_create'", nullptr);
            return 0;
        }
        BloomUp* ret = BloomUp::create(arg0, arg1, arg2, arg3);
        object_to_luaval<BloomUp>(tolua_S, "BloomUp",(BloomUp*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "BloomUp:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_BloomUp_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_BloomUp_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (BloomUp)");
    return 0;
}

int lua_register_Blur_Action_BloomUp(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"BloomUp");
    tolua_cclass(tolua_S,"BloomUp","BloomUp","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"BloomUp");
        tolua_function(tolua_S,"create", lua_Blur_Action_BloomUp_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(BloomUp).name();
    g_luaType[typeName] = "BloomUp";
    g_typeCast["BloomUp"] = "BloomUp";
    return 1;
}

int lua_Blur_Action_BlurFilter_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"BlurFilter",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BlurFilter:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BlurFilter:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BlurFilter:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BlurFilter_create'", nullptr);
            return 0;
        }
        BlurFilter* ret = BlurFilter::create(arg0, arg1, arg2);
        object_to_luaval<BlurFilter>(tolua_S, "BlurFilter",(BlurFilter*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "BlurFilter:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "BlurFilter:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "BlurFilter:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "BlurFilter:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_BlurFilter_create'", nullptr);
            return 0;
        }
        BlurFilter* ret = BlurFilter::create(arg0, arg1, arg2, arg3);
        object_to_luaval<BlurFilter>(tolua_S, "BlurFilter",(BlurFilter*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "BlurFilter:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_BlurFilter_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_BlurFilter_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (BlurFilter)");
    return 0;
}

int lua_register_Blur_Action_BlurFilter(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"BlurFilter");
    tolua_cclass(tolua_S,"BlurFilter","BlurFilter","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"BlurFilter");
        tolua_function(tolua_S,"create", lua_Blur_Action_BlurFilter_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(BlurFilter).name();
    g_luaType[typeName] = "BlurFilter";
    g_typeCast["BlurFilter"] = "BlurFilter";
    return 1;
}

int lua_Blur_Action_RedFilter_create(lua_State* tolua_S)
{
    int argc = 0;
    bool ok  = true;

#if COCOS2D_DEBUG >= 1
    tolua_Error tolua_err;
#endif

#if COCOS2D_DEBUG >= 1
    if (!tolua_isusertable(tolua_S,1,"RedFilter",0,&tolua_err)) goto tolua_lerror;
#endif

    argc = lua_gettop(tolua_S) - 1;

    if (argc == 3)
    {
        double arg0;
        double arg1;
        double arg2;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "RedFilter:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "RedFilter:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "RedFilter:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_RedFilter_create'", nullptr);
            return 0;
        }
        RedFilter* ret = RedFilter::create(arg0, arg1, arg2);
        object_to_luaval<RedFilter>(tolua_S, "RedFilter",(RedFilter*)ret);
        return 1;
    }
    if (argc == 4)
    {
        double arg0;
        double arg1;
        double arg2;
        bool arg3;
        ok &= luaval_to_number(tolua_S, 2,&arg0, "RedFilter:create");
        ok &= luaval_to_number(tolua_S, 3,&arg1, "RedFilter:create");
        ok &= luaval_to_number(tolua_S, 4,&arg2, "RedFilter:create");
        ok &= luaval_to_boolean(tolua_S, 5,&arg3, "RedFilter:create");
        if(!ok)
        {
            tolua_error(tolua_S,"invalid arguments in function 'lua_Blur_Action_RedFilter_create'", nullptr);
            return 0;
        }
        RedFilter* ret = RedFilter::create(arg0, arg1, arg2, arg3);
        object_to_luaval<RedFilter>(tolua_S, "RedFilter",(RedFilter*)ret);
        return 1;
    }
    luaL_error(tolua_S, "%s has wrong number of arguments: %d, was expecting %d\n ", "RedFilter:create",argc, 3);
    return 0;
#if COCOS2D_DEBUG >= 1
    tolua_lerror:
    tolua_error(tolua_S,"#ferror in function 'lua_Blur_Action_RedFilter_create'.",&tolua_err);
#endif
    return 0;
}
static int lua_Blur_Action_RedFilter_finalize(lua_State* tolua_S)
{
    printf("luabindings: finalizing LUA object (RedFilter)");
    return 0;
}

int lua_register_Blur_Action_RedFilter(lua_State* tolua_S)
{
    tolua_usertype(tolua_S,"RedFilter");
    tolua_cclass(tolua_S,"RedFilter","RedFilter","cc.ActionInterval",nullptr);

    tolua_beginmodule(tolua_S,"RedFilter");
        tolua_function(tolua_S,"create", lua_Blur_Action_RedFilter_create);
    tolua_endmodule(tolua_S);
    std::string typeName = typeid(RedFilter).name();
    g_luaType[typeName] = "RedFilter";
    g_typeCast["RedFilter"] = "RedFilter";
    return 1;
}
TOLUA_API int register_all_Blur_Action(lua_State* tolua_S)
{
	tolua_open(tolua_S);
	
	tolua_module(tolua_S,nullptr,0);
	tolua_beginmodule(tolua_S,nullptr);

	lua_register_Blur_Action_RedFilter(tolua_S);
	lua_register_Blur_Action_BlurFilter(tolua_S);
	lua_register_Blur_Action_EdgeFilterAct(tolua_S);
	lua_register_Blur_Action_BloomUp(tolua_S);
	lua_register_Blur_Action_BoxfilterAct(tolua_S);
	lua_register_Blur_Action_SharpFilterAct(tolua_S);

	tolua_endmodule(tolua_S);
	return 1;
}

