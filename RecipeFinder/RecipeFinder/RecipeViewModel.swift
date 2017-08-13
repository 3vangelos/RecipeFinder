//
//  RecipeViewModel.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

class RecipeViewModel {
    private var recipes : [Recipe] = []
    
    var searchTerm : String?
    
    func requestRecipeWithSearchTerm(_ term: String, successBlock: @escaping () -> () = {}, errorBlock: @escaping (String) -> () = {_ in }) {
        RecipeStore.requestRecipeWithSearchTerm(term, successBlock: { recipes in
            self.recipes = recipes
            successBlock()
        }) { error in
            switch error {
            case .someNetworkError:
                errorBlock(error.localizedDescription)
            default:
                errorBlock("Some other Error occured")
            }
        }
    }
    
    func imageDataForIndexPath(_ indexPath: IndexPath, completion:@escaping(Data?) -> ()) {
        guard let urlString = recipes[indexPath.row].thumbnail else {
            return completion(nil)
        }
        
        RecipeStore.imageDataFromUrlString(urlString, completion: { data in
            completion(data)
        })
    }
    
    func screenTitle() -> String {
        return "Recipe Finder"
    }
    
    func numberOfRecipes() -> Int {
        return recipes.count
    }
    
    func recipeTitleAtIndexPath(_ indexPath: IndexPath) -> String {
        return recipes[indexPath.row].title ?? "No Title"
    }
}
