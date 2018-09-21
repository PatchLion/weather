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