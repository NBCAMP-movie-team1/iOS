//
//  SearchManager.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import Foundation

class SearchManager{
    var filteredArr: [String] = []
    func fetchData(text: String, completionHandler: @escaping() -> Void) {
        MovieRequest.searchMovieRequest(text, page: 1) { result in
            switch result {
            case .success(let movies):
                self.filteredArr = movies.map { $0.title.lowercased() }.filter { $0.contains(text) }
                print("\n")
                if self.filteredArr.isEmpty {
                    print("똑바로 적어")
                } else {
                    completionHandler()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
