#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from database.instance import *
from database.tables import *
from database.settings import ConnectionString
import datetime

DBInstance.resetConnection(ConnectionString)


class Weathers(object):

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


    #获取天气情况
    def weather_with_location(self, location):
        date_string = datetime.date.today().strftime("%Y-%m-%d")
        if date_string != self.last_update_date(location):
            #需要拉取远程API数据
            pass

        #读取数据库数据
        pass

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
print(w.set_last_udpate_date("成都"))
print(w.last_update_date("成都"))