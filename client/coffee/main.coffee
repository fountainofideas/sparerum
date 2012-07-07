

require ["drinkmap"], (DrinkMap) ->
    geo = new DrinkMap.Geo();
    geo.getLocation (location) ->
        drinkMap = new DrinkMap.Map($("#map_canvas"),location);
        drinkApi = new DrinkMap.Api("..");
        drinkApi.getOffers location, (response) ->
            drinkMap.addOffer new DrinkMap.DrinkOffer(offerData) for offerData in response.offers;
        
