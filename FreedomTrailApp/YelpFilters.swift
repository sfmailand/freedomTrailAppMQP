//
//  yelpRestaurantFilters.swift
//  FreedomTrailApp
//
//  Created by Sam Mailand on 3/24/16.
//  Copyright © 2016 Sam Mailand. All rights reserved.
//

import Foundation


public class YelpFilters{
    
    private var restaurants: [String: String]
    
    init(){
        restaurants = [:]
        initRestaurants()
    }
    
    
    private func initRestaurants(){
        restaurants["New American"] = "newamerican"
        restaurants["Tradiational American"] = "tradamerican"
        restaurants["Asian Fusion"] = "asianfusion"
        restaurants["BBQ"] = "bbq"
        restaurants["Burgers"] = "burgers"
        restaurants["Cafes"] = "cafes"
        restaurants["Chinese"] = "chinese"
        restaurants["German"] = "german"
        restaurants["Gluten Free"] = "gluten_free"
        restaurants["Italian"] = "italian"
        restaurants["Japanese"] = "japanese"
        restaurants["Latin"] = "latin"
        restaurants["Mexican"] = "mexican"
        restaurants["Middle Eastern"] = "mideastern"
        restaurants["Pizza"] = "pizza"
        restaurants["Seafood"] = "seafood"
        restaurants["Sandwiches"] = "sandwiches"
    }
    
    public func getRestaurantIdentifierByType(rType: String) -> String{
        return restaurants[rType]!
    }
    
    public func getRestaurantTypes() -> [String]{
        return Array(restaurants.keys).sort()
    }
    
    
    
}