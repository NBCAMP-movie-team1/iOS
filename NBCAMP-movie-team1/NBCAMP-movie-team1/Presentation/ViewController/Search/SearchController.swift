//
//  SearchController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class SearchControllerManager: UIViewController, UISearchResultsUpdating {
    var filteredArr: [String] = []

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased() else { return }

        MovieRequest.searchMovieRequest(text, page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.filteredArr = movies.map { $0.title.lowercased() }.filter { $0.contains(text) }
                    print("\n")
                    for i in self.filteredArr {
                        print(i)
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
        dump(searchController.searchBar.text)
    }
    
    func setupSearchController(for viewController: UIViewController) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화 제목 검색어"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")

        searchController.searchResultsUpdater = self

        viewController.navigationItem.searchController = searchController
        viewController.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
