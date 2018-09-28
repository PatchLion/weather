from flask import request
from app import app
from weathers.weathers import Weathers

w = Weathers()
@app.route("/weather")
def weather():
    location = request.args.get('location')
    return w.weather_with_location(location)


