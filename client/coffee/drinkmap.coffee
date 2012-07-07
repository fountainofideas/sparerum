defaultLocation =
    lat:51.524419
    lon:-0.080112
    
class Api
    constructor: (@rootPath) ->
    getOffers: (location, callback) ->
        $.getJSON(@rootPath+"/offer/#{location.lat}:#{location.lon}",callback)

class Geo
    getLocation:(callback) ->
        if (navigator.geolocation)
            extractlocation = (position) ->
                return {
                    lat: position.coords.latitude
                    lon: position.coords.longitude
                }
            navigator.geolocation.getCurrentPosition(
                (position) ->
                    callback extractlocation(position) 
                , () ->
                    callback defaultLocation)
        else
            callback defaultLocation
        

class DrinkOffer
    constructor: (offerData) ->
        @location=offerData.location
        @description=offerData.description

class Map
    constructor: (canvasElement,location) ->
        mapOptions =
            center: new google.maps.LatLng(location.lat,location.lon)
            zoom: 16
            mapTypeId: google.maps.MapTypeId.ROADMAP
        @googlemap = new google.maps.Map($("#map_canvas").get(0), mapOptions);
        @offers=[]
        
    panTo: (location) ->
        @googlemap.panTo new google.maps.LatLng(location.lat,location.lon)
    
    addOffer: (drinkOffer) ->
        markerOptions =
            position: new google.maps.LatLng(drinkOffer.location.lat, drinkOffer.location.lon)
            title: drinkOffer.description
            map: @googlemap
        @offers.push new google.maps.Marker(markerOptions);
        

define(
    "Map":Map
    "DrinkOffer":DrinkOffer
    "Api":Api
    "Geo":Geo
    )
