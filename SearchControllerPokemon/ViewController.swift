//
//  ViewController.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate {
    
    fileprivate let reuseCellIdentifier = "reuseCellIdentifier"
    fileprivate let superHeroList = SuperHeroDataSource.createList()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    fileprivate var filteredSuperHeroList = [SuperHero]()
    @IBOutlet weak var tableView: UITableView!
    
    var nameArray: [String] = UserDefaults.standard.object(forKey: "name") as? [String] ?? []
    var imageArray: [String] = UserDefaults.standard.object(forKey: "image") as? [String] ?? []
   


    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
   
    
    func configureSearchController() {
       tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.scopeButtonTitles = ["All", "Grass", "Fire", "Water"]
        searchController.searchBar.delegate = self
    }
    
    func filterSearchController(_ searchBar: UISearchBar) {
        guard let scopeString = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] else { return }
        let selectedElement = SuperHero.Element(rawValue: scopeString) ?? .All
        let searchText = searchBar.text ?? ""
        
        
        filteredSuperHeroList = superHeroList.filter { pokemon in
            let isElementMatching = (selectedElement == .All) || (pokemon.element == selectedElement)
            let isMatchingSearchText = pokemon.name.lowercased().contains(searchText.lowercased()) || searchText.lowercased().count == 0
            return isMatchingSearchText && isElementMatching
        }
        tableView.reloadData()
    }

}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectedViewController") as! SelectedViewController
        vc.modalPresentationStyle = .popover
       
        let pokemon = searchController.isActive ? filteredSuperHeroList[indexPath.row] : superHeroList[indexPath.row]
        vc.id = pokemon.id
        vc.imageString = pokemon.image
        vc.heroName = pokemon.name
          self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier, for: indexPath)
        let pokemon = searchController.isActive ? filteredSuperHeroList[indexPath.row] : superHeroList[indexPath.row]
        cell.textLabel!.text = pokemon.name
        cell.detailTextLabel?.text = pokemon.element.rawValue
        let imageUrl = URL(string: pokemon.image)
        cell.imageView?.kf.setImage(with: imageUrl)
        cell.imageView?.kf.setImage(with: imageUrl, placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, URL) in
            cell.setNeedsLayout()
        })
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredSuperHeroList.count : superHeroList.count
    }

}

extension ViewController : UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
         filterSearchController(searchController.searchBar)
    }
    
}

extension ViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterSearchController(searchBar)
    }
    
}

