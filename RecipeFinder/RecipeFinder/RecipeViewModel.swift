//
//  RecipeViewModel.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos (415) on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import Foundation

class RecipeViewModel {
    var recipes : [Recipe] = []
    
    var searchTerm : String?
    
    func requestRecipe(term: String, errorAction: @escaping () -> () = {}, finishAction: @escaping () -> () = {}) {
        RecipeStore.requestRecipe(term: term, success: { recipes in
            self.recipes = recipes
            finishAction()
        }) { error in
            errorAction()
        }
    }
}
