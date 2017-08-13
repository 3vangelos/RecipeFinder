//
//  ViewController.swift
//  RecipeFinder
//
//  Created by Sismanidis, Evangelos on 13.05.17.
//  Copyright © 2017 Private. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = RecipeViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        searchController.searchBar.searchBarStyle = .minimal
        searchController.searchBar.backgroundColor = UIColor.white
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.tableHeaderView = searchController.searchBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        self.view = view
        self.title = viewModel.screenTitle()
    }

    
    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRecipes()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellForIndexPath(indexPath)
    }
    
    
    // MARK: UISearchDelegates
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let term = searchController.searchBar.text, term.characters.count > 0 else {
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(requestReceipt), object: nil)
        self.perform(#selector(requestReceipt), with: nil, afterDelay: 0.5)
    }
    
    func requestReceipt() {
        viewModel.requestRecipeWithSearchTerm(self.searchController.searchBar.text!, successBlock: {
            self.reloadRecipes()
        }, errorBlock: { error in
            Alerts.showNetworkError(target: self, title: "Error", description: error)
        })
    }
    
    
    // MARK: Private Helpers
    
    private func reloadRecipes() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func cellForIndexPath(_ indexPath: IndexPath) -> RecipeTableViewCell {
        let cell = RecipeTableViewCell()
        cell.recipeTitleLabel.text = viewModel.recipeTitleAtIndexPath(indexPath)
        viewModel.imageDataForIndexPath(indexPath) { data in
            
            DispatchQueue.main.async {
                if let data = data {
                    let image = UIImage(data: data)
                    cell.recipeImageView.image = image
                }
            }
        }
        return cell
    }
}
