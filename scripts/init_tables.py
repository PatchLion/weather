#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from database import DBInstance
from database.tables import *
from database.settings import ConnectionString

DBInstance.resetConnection(ConnectionString)
DBInstance.initTables()
'''
#用户名
DBInstance.removeRecords(User)
DBInstance.addOrRecord(User(user="admin", password=stringMD5("admin"), is_admin=True))
'''