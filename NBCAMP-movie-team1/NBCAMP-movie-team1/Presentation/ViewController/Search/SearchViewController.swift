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
    var sectionLabel: MovieSectionLabel!
    
    override func viewDidLoad() {
        configureSectionLabel()
        
        configureCollectionView()
        view.backgroundColor = .white
        setupSearchController(for: self)
        collectionViewDelegate()
        registerCollectionView()
        
        searchManager.fetchPopularMovies {
            DispatchQueue.main.async {
                self.customCollectionView.reloadData()
                self.sectionLabel.isHidden = false
            }
        }
    }
    
    func configureSectionLabel() {
        sectionLabel = MovieSectionLabel(text: "추천 영화")
        sectionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionLabel)
        sectionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        sectionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sectionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
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
        customCollectionView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor, constant: 15).isActive = true
        customCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        let cellHeight = cellWidth * 1.3
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        lay.minimumLineSpacing = 70
        lay.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 70, right: 0)
        lay.minimumInteritemSpacing = 0

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let searchMovie = searchManager.filteredArr[indexPath.row]
        let detailView = DetailMovieViewController(movieId: searchMovie.id)
        
        present(detailView, animated: true, completion: nil)
    }
}

extension SearchViewController: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        searchManager.fetchPopularMovies {
            DispatchQueue.main.async {
                self.sectionLabel.text = "추천 목록"
                self.customCollectionView.reloadData()
                let indexPath = IndexPath(item: 0, section: 0)
                self.customCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            }
        }
    }
}


extension SearchViewController: UISearchBarDelegate {
    func setupSearchController(for viewController: UIViewController) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "제목으로 검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backButtonAction))
        
        searchController.searchBar.delegate = self
        searchController.delegate = self
        
        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func backButtonAction() {
        searchManager.fetchPopularMovies {
            DispatchQueue.main.async {
                self.customCollectionView.reloadData()
            }
        }
        self.sectionLabel.text = "추천 목록"
        let indexPath = IndexPath(item: 0, section: 0)
        self.customCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
        if let searchController = navigationItem.searchController {
            searchController.searchBar.text = ""
        }
        navigationController?.popViewController(animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text?.lowercased() {
            searchManager.fetchData(text: text) {
                DispatchQueue.main.async{ self.customCollectionView.reloadData() }
            }
        }
        self.sectionLabel.text = "검색 목록"
        let indexPath = IndexPath(item: 0, section: 0)
        self.customCollectionView.scrollToItem(at: indexPath, at: .top, animated: true)
    }
}
