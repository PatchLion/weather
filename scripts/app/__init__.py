#!/usr/bin/env python
# -*- coding: utf-8 -*-

from flask import Flask

app = Flask("weathers")
from .views import *

def start_server(ip="0.0.0.0", port=5050):
    app.run(host=ip, port=port, debug=True)