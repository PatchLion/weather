#!/usr/bin/env python
# -*- coding: utf-8 -*-

from weathers.weathers import *




w = Weathers()
#print(w.cities("成"))
#print(datetime.date.today())
#print(w.last_update_date())
#print(w.set_last_udpate_date("成都"))
#print(w.last_update_date("成都"))
print(w.request_network_api("成都"))
print(w.weather_with_location("成都"))