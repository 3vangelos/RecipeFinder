//
//  RecipeTableViewCell.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.08.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    
    let recipeImageView = UIImageView()
    var recipeTitleLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let MARGIN : CGFloat = 17
        
        self.addSubview(recipeImageView)
        recipeImageView.contentMode = .scaleAspectFill
        recipeImageView.clipsToBounds = true
        recipeImageView.image = #imageLiteral(resourceName: "default")
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: MARGIN).isActive = true
        recipeImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        recipeImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true

        self.addSubview(recipeTitleLabel)
        recipeTitleLabel.numberOfLines = 0
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.leadingAnchor.constraint(equalTo: recipeImageView.trailingAnchor, constant: 2*MARGIN).isActive = true
        recipeTitleLabel.topAnchor.constraint(equalTo: recipeImageView.topAnchor).isActive = true
        recipeTitleLabel.bottomAnchor.constraint(equalTo: recipeImageView.bottomAnchor).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-MARGIN).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
