#!/usr/bin/env python
# -*- coding: utf-8 -*-

from database import TableBase
from sqlalchemy import *

'''
#用户表
class User(TableBase):
    __tablename__ = "User"

    id = Column(Integer(), primary_key=True, autoincrement=True) #id
    user = Column(String(256), nullable=False) #用户名
    password = Column(String(256), nullable=False) #密码
    is_admin = Column(Boolean(), nullable=False, default=False) #是否是管理员
'''

#区域表
class Area(TableBase):
    __tablename__ = "Area"

    areaid = Column(String(), primary_key=True) #区域ID
    namecn = Column(String(), nullable=False) #名称
    districtcn = Column(String(), nullable=False) #地区
    provcn = Column(String(), nullable=False) #省份
    nationcn = Column(String(), nullable=False) #国家

#天气预报表
class Weather(TableBase):
    __tablename__ = "Weather"

    id = Column(INTEGER(), primary_key=True, autoincrement=True) #id
    day_weather = Column(String())#- day_weather 	白天天气
    night_weather = Column(String())#- night_weather 	晚上天气
    day_air_temperature = Column(String())#- day_air_temperature 	白天天气温度(摄氏度)
    night_air_temperature = Column(String())#- night_air_temperature 	晚上天气温度(摄氏度)
    day_wind_direction = Column(String())#- day_wind_direction 	白天风向编号
    night_wind_direction = Column(String())#- night_wind_direction 	晚上风向编号
    day_wind_power = Column(String())#- day_wind_power 	白天风力编号
    night_wind_power = Column(String())#- night_wind_power 	晚上风力编号
    sun_begin_end = Column(String())#- sun_begin_end 	日出日落时间(中间用|分割)
    day = Column(String())#- day 	当前天日期
    weekday = Column(INTEGER())#- weekday 	星期几
    day_weather_code = Column(String())#- day_weather_code 	白天的天气编码
    night_weather_code = Column(String())#- night_weather_code 	晚上的天气编码
    air_press = Column(String())#- air_press 	大气压
    jiangshui = Column(String())#- jiangshui 	降水概率

#生活指数
#-- beauty 	化妆指数
#-- clothes 	穿衣指数
#-- cold 	感冒
#-- comfort 	舒适
#-- glass 	太阳镜
#-- sports 	运动
#-- travel 	旅游
#-- uv 	紫外线
#-- wash_car 	洗车
#-- aqi 	大气污染
#-- ac 	空调控制
#-- ag 	过敏指数
#-- cl 	晨练指数
#-- dy 	钓鱼指数
#-- gj 	逛街指数
#-- hc 	划船指数
#-- ls 	晾晒指数
#-- mf 	美发指数
#-- nl 	夜生活指数
#-- pj 	啤酒指数
#-- pk 	放风筝指数
#-- yh 	约会指数
#-- zs 	中暑指数
#-- xq 	心情指数
class Index(TableBase):
    __tablename__ = "Index"

    id = Column(INTEGER(), primary_key=True, autoincrement=True) #id
    weather_id = Column(INTEGER()) # 和Weather表的id一致
    type = Column(String()) #指数类型
    title = Column(String()) #指数标题
    desc = Column(String()) #指数描述

#最后更新日期
class LastUpdateDate(TableBase):
    __tablename__ = "LastUpdateDate"

    type = Column(String(), primary_key=True)
    date = Column(String())