//
//  SearchViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class SearchViewController: UIViewController{
    var customCollectionView: CustomCollectionView! //
    var searchManager = SearchManager()
    
    override func viewDidLoad() {
        configureCollectionView()
        view.backgroundColor = .white
        setupSearchController(for: self)
        collectionViewDelegate()
        registerCollectionView()
    }
    
    func registerCollectionView() {
        customCollectionView.register(CollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cellIdentifier")
    }
    
    func collectionViewDelegate() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
    }
    
    func configureCollectionView() {
        customCollectionView = CustomCollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        customCollectionView.translatesAutoresizingMaskIntoConstraints = false
        customCollectionView.backgroundColor = .clear
        self.view.addSubview(customCollectionView)
        customCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 140).isActive = true
        customCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        customCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchManager.filteredArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        cell.tltieLabel.text = searchManager.filteredArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func setupSearchController(for viewController: UIViewController) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화 볼까나"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        searchController.searchBar.delegate = self
        
        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased() {
            searchManager.fetchData(text: text) {
                DispatchQueue.main.async{ self.customCollectionView.reloadData() }
            }
        }
    }
}
