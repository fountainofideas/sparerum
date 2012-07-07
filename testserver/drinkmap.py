from flask import *
import random

app = Flask(__name__)

@app.route('/offer/<lat>:<lon>')
def getOffers(lat,lon):
    lat=float(lat)
    lon=float(lon)
    offers = [{"location":{"lat":lat+random.random()*0.02,"lon":lon+random.random()*0.02},"description":"YO"} for i in range(5)]
    offerResponse = {"offers":offers}
    return jsonify(offerResponse)
    
if __name__ == "__main__":
    app.run(debug=True)
