#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from database.instance import *
from database.tables import *
from database.settings import ConnectionString
from logger import createLogger
import datetime, requests

DBInstance.resetConnection(ConnectionString)

#易源数据-天气预报
SAWeatherURL = "http://saweather.market.alicloudapi.com/area-to-weather";

class Weathers(object):
    _logger = createLogger("Weathers")

    #查询城市，keyword为模糊查询关键字，可为空
    def cities(self, keyword=''):
        cities_tree = {}
        for r in DBInstance.records(Area, Area.namecn.ilike("%%" + keyword + "%%")):
            if r.nationcn not in cities_tree.keys():
                cities_tree[r.nationcn] = {}
            if r.provcn not in cities_tree[r.nationcn].keys():
                cities_tree[r.nationcn][r.provcn] = {}
            if r.districtcn not in cities_tree[r.nationcn][r.provcn].keys():
                cities_tree[r.nationcn][r.provcn][r.districtcn] = []
            cities_tree[r.nationcn][r.provcn][r.districtcn].append({"areaid":r.areaid, "name":r.namecn})
        return json.dumps(cities_tree,ensure_ascii=False)

    def request_network_api(self,location):
        headers = {"Authorization": "APPCODE 377ab35f6c624993b54e8c75345d23ba", "Content-Type": "application/json; charset=utf-8"}
        res = requests.get(SAWeatherURL+"?area="+location +"&needMoreDay=1&needIndex=1", headers=headers)
        weather_data = json.loads(res.content, encoding="utf-8")
        #print(json.dumps(, ensure_ascii=False))
        if weather_data["showapi_res_code"] != 0:
            Weathers._logger.warn("获取天气信息失败："+weather_data["showapi_res_error"])
            return

        print(json.dumps(weather_data, ensure_ascii=False))
        data_body = weather_data["showapi_res_body"]
        days = ["f1", "f2", "f3", "f4", "f5", "f6", "f7"]
        for day in days:
            if day in data_body.keys():
                day_info = data_body[day]
                if day_info is not None:
                    w = {}
                    w["areaid"] = data_body["cityInfo"]["c1"]
                    w["day"] = data_body[day]["day"]
                    w["day_weather"] = data_body[day]["day_weather"]
                    w["night_weather"] = data_body[day]["night_weather"]
                    w["day_air_temperature"] = data_body[day]["day_air_temperature"]
                    w["night_air_temperature"] = data_body[day]["night_air_temperature"]
                    w["day_wind_direction"] = data_body[day]["day_wind_direction"]
                    w["night_wind_direction"] = data_body[day]["night_wind_direction"]
                    w["day_wind_power"] = data_body[day]["day_wind_power"]
                    w["night_wind_power"] = data_body[day]["night_wind_power"]
                    w["sun_begin_end"] = data_body[day]["sun_begin_end"]
                    w["weekday"] = data_body[day]["weekday"]
                    w["day_weather_code"] = data_body[day]["day_weather_code"]
                    w["night_weather_code"] = data_body[day]["night_weather_code"]
                    #w["air_press"] = data_body[day]["air_press"]
                    w["jiangshui"] = data_body[day]["jiangshui"]

                    if not DBInstance.isRecordExist(Weather, and_(Weather.areaid==w["areaid"], Weather.day==w["day"])):
                        temp_w = Weather(**w)
                        temp_size = DBInstance.addRecord(temp_w)
                        if 1== temp_size:
                            #print("11111")
                            indexs = data_body[day]["index"]
                            temps = []

                            for key in indexs.keys():
                                ititle = indexs[key]["title"]
                                idesc = indexs[key]["desc"]

                                temps.append(Index(**{"weather_id":temp_w.id, "title":ititle, "desc":idesc, "type": key}))

                            if len(temps) > 0:
                                s = DBInstance.addRecord(temps)
                                print("===>", s)


        self.set_last_udpate_date(location)

    #获取天气情况
    def weather_with_location(self, location):
        date_string = datetime.date.today().strftime("%Y-%m-%d")
        if date_string != self.last_update_date(location):
            #需要拉取远程API数据
            self.request_network_api(location)

        #读取数据库数据
        key_date_string = date_string.replace("-", "")

        #读取地区id
        area_rs = DBInstance.records(Area, Area.namecn==location)
        if len(area_rs) > 0:
            weather_rs = DBInstance.records(Weather, and_(Weather.day==key_date_string, Weather.areaid==area_rs[0].areaid))

            for temp_w in weather_rs:
                pass

        return json.dumps({"code":-1, "message":"获取天气预报异常"}, ensure_ascii=False)

    #获取最后更新日期
    def last_update_date(self, location):
        if len(location) == 0:
            return
        rs = DBInstance.records(LastUpdateDate, LastUpdateDate.type==location)
        if len(rs) == 0:
            return datetime.date.fromtimestamp(0)
        return datetime.datetime.strptime(rs[0].date,'%Y-%m-%d').date()

    #设置最后更新日期
    def set_last_udpate_date(self, location):
        if len(location) == 0:
            return
        date_string = datetime.date.today().strftime("%Y-%m-%d")
        if DBInstance.isRecordExist(LastUpdateDate, LastUpdateDate.type==location):
            return DBInstance.updateRecords(LastUpdateDate, LastUpdateDate.type==location, {LastUpdateDate. date:date_string})
        else:
            return DBInstance.addRecord(LastUpdateDate(type=location, date=date_string))



w = Weathers()
#print(w.cities("成"))
#print(datetime.date.today())
#print(w.last_update_date())
#print(w.set_last_udpate_date("成都"))
#print(w.last_update_date("成都"))
print(w.weather_with_location("成都"))