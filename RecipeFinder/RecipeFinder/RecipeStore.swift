//
//  RecipeStore.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

struct RecipeStore {
    
    static func requestRecipe(term: String, success:@escaping([Recipe]) -> (), errorAction: @escaping(String) -> ()) {
        let term = term.replacingOccurrences(of: " ", with: ",")
        let urlString = "http://www.recipepuppy.com/api/?q=\(term)"
        let url = URL(string: urlString)!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/javascript", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (responseData, response, error) -> Void in
            guard let responseData = responseData, error == nil else { return }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: responseData, options:[]) as! [String: Any]
            if let responseJSON = responseJSON {
                let results : [[String:String]] = responseJSON["results"] as! [[String : String]]
                let recipes = results.map{ Recipe(json: $0) }
                success(recipes)
            } else {
                errorAction("Error")
            }
            }.resume()
    }
}
