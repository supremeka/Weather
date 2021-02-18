//
//  ViewController.swift
//  WeatherApp
//
//  Created by Кирилл on 2/12/21.
//

import UIKit

class ViewController: UIViewController, UISearchResultsUpdating {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNavigationBar()
    }
    private func setupNavigationBar() {
        self.navigationItem.title = "Wether"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func updateSearchResults(for searchController: UISearchController){
        
}
}

