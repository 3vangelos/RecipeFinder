//
//  RecipeStore.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

struct RecipeStore {
    
    public enum RequestError: Error {
        case invalidURL
        case someNetworkError(Error)
    }
    
    static func requestRecipeWithSearchTerm(_ term: String, successBlock:@escaping([Recipe]) -> (), errorBlock: @escaping(RequestError) -> ()) {
        let term = term.replacingOccurrences(of: " ", with: ",")
        let urlString = "http://www.recipepuppy.com/api/?q=\(term)"
        guard let url = URL(string: urlString) else {
            errorBlock(.invalidURL)
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (responseData, response, error) -> Void in
            guard let responseData = responseData, error == nil else {
                errorBlock(.someNetworkError(error!))
                return
            }
            
            do {
                let responseJSON = try JSONSerialization.jsonObject(with: responseData, options:[]) as! [String: Any]
                let results : [[String:String]] = responseJSON["results"] as! [[String : String]]
                let recipes = results.map{ Recipe(json: $0) }
                successBlock(recipes)

            } catch {
                errorBlock(.someNetworkError(error))
            }
            }.resume()
    }
    
    static func imageDataFromUrlString(_ string: String, completion:@escaping(Data?) -> ()) {
        guard let url = URL(string: string) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            completion(data)
        }).resume()
    }
}

