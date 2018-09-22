#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os

DEFAULT_PATH = os.path.realpath(os.path.join(os.path.split(os.path.realpath(__file__))[0] + "/../..", "weathers.db"))
#ConnectionString = "mssql+pymssql://sa:Root123456@127.0.0.1:1433/Devices?charset=utf8"
ConnectionString = "sqlite:///{}".format(DEFAULT_PATH)

print(ConnectionString)