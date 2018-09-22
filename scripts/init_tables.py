#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from database import DBInstance
from database.tables import *
from database.settings import ConnectionString
import xlrd

DBInstance.resetConnection(ConnectionString)
DBInstance.initTables()
'''
#
DBInstance.removeRecords(User)
DBInstance.addOrRecord(User(user="admin", password=stringMD5("admin"), is_admin=True))
'''


DBInstance.removeRecords(Area)
workbook = xlrd.open_workbook('weather_areaid.xlsx')
#print(workbook.sheet_names())  # 查看所有sheet
booksheet = workbook.sheet_by_index(0)  # 用索引取第一个sheet
#booksheet = workbook.sheet_by_name('Sheet 1')  # 或用名称取sheet
rows = booksheet.get_rows()
for row in list(rows)[1:]:
    areaid = str(int(row[0].value))
    print("AREA:", row)
    DBInstance.addOrRecord(Area(areaid=areaid, namecn=row[2].value, districtcn=row[4].value, provcn=row[6].value, nationcn=row[8].value))


#for area in DBInstance.records(Area):
    #print("=>", area.NAMECN)


print("ALL DONE!!!")