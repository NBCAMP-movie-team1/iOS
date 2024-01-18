//
//  SearchViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class SearchViewController: UIViewController{
    var customCollectionView: CustomCollectionView!
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
        customCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
        customCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

extension SearchViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchManager.filteredArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let searchList = searchManager.filteredArr[indexPath.row]
        let cell = customCollectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath) as! CollectionViewCell
        let link = "https://image.tmdb.org/t/p/w500\(searchList.imagePath)"
        ImageLoader.loadImage(from: link, into: cell.titleImage)
        cell.titleLabel.text = searchList.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.size.width * 0.5
        let cellHeight = cellWidth * 1.7
        let lay = collectionViewLayout as! UICollectionViewFlowLayout

        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

        
        return CGSize(width: widthPerItem, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchMovie = searchManager.filteredArr[indexPath.row]
        let detailView = DetailMovieViewController(movieId: searchMovie.id)
        
        present(detailView, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        searchManager.filteredArr.removeAll()
        customCollectionView.reloadData()
    }
}


extension SearchViewController: UISearchBarDelegate {
    func setupSearchController(for viewController: UIViewController) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화 볼까나"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
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
