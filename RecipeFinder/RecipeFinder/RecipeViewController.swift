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
        tableView.tableHeaderView = searchController.searchBar
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.addSubview(tableView)
        
        // Normally I would use a Library like Snapkit for setting the Autolayout constraints
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        self.view = view
        self.title = "RECEIPT FINDER"
    }

    // MARK: UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let recipe = viewModel.recipes[indexPath.row]
        cell.textLabel?.text = recipe.title
        return cell
    }
    
    // MARK: UISearchDelegates
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let term = searchController.searchBar.text, term.characters.count > 2 else {
            return
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(requestReceipt), object: nil)
        self.perform(#selector(requestReceipt), with: nil, afterDelay: 0.5)
    }
    
    func requestReceipt() {
        viewModel.requestRecipe(term: self.searchController.searchBar.text!, errorAction: {
            print("Error")
        }) {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
