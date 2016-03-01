//
//  M1905ConstantDefinition.h
//  FilmSiteClient
//
//  Created by 陈虎 on 15/12/7.
//  Copyright © 2015年 陈虎. All rights reserved.
//

#ifndef M1905ConstantDefinition_h
#define M1905ConstantDefinition_h

// 购买电影记录
#define BUY_FILM     @"BUY_FILM"
#define NormalPlayType  @"NormalPlayType"

// 结果代码
#define NET_RES_SUCCESS 0
#define NET_RES_SERVER_MAINTAINANCE 99      //服务器维护
#define NET_RES_PARAM_WRONG 101             //参数错误
#define NET_RES_ILLEGAL_ASK 102             //非法请求
#define NET_RES_UNAUTH_USER 103             //未授权用户
#define NET_RES_NODATA 404                  //无数据
#define NET_RES_SERVER_PROBLEM 500          //服务器错误
#define NET_RES_UNDENIED 600                //自定义错误
#define NET_RES_HTTP_SUCCESS 200            //httpCode200(成功)

// 结果代码（用户登录）
#define NET_RES_LOGIN_WRONG_INFO    (-2)    //错误的登录信息

// 请求返回节点定义
#define SERVER_RESULT       @"res/result"
#define SERVER_MESSAGE      @"message"
#define SERVER_DATA         @"data"

#define SERVER_ITEM         @"item"
#define RechargeWay         @"way"
#define DeviceNum           @"deviceNum"
#define CLIENT_NAME         @"FilmSiteClient"


// 通知
#define kUserAuthPlayChangeNotify @"kUserAuthPlayChangeNotify"

#endif /* M1905ConstantDefinition_h */
