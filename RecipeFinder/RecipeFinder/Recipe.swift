//
//  Recipe.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos (415) on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

// JSON Example from http://www.recipepuppy.com/api
// { "title":"Monterey Turkey Omelet",
//   "href":"http:\/\/allrecipes.com\/Recipe\/Monterey-Turkey-Omelet\/Detail.aspx",
//   "ingredients":"butter, eggs, garlic, green pepper, monterey jack cheese, onions, turkey, water",
//   "thumbnail":"http:\/\/img.recipepuppy.com\/5506.jpg" }

struct Recipe {
    let title: String?
    let url: String?
    let ingridients: [String]?
    let thumbnail: String?
    
    init(json: [String: String]) {
        self.title = json["title"]
        self.url = json["href"]
        self.ingridients = json["ingridients"]?.components(separatedBy: ", ")
        self.thumbnail = json["thumbnail"]
    }
}
