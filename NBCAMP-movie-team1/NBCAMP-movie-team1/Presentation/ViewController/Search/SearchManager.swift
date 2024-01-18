//
//  SearchManager.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import Foundation

class SearchManager{
    var filteredArr: [MovieList] = []
    func fetchData(text: String, completionHandler: @escaping() -> Void) {
        MovieRequest.searchMovieRequest(text, page: 1) { result in
            switch result {
            case .success(let movies):
                self.filteredArr = movies.map {
                    MovieList(title: $0.title, imagePath: $0.posterPath!, popularity: $0.popularity)
                }.filter { $0.title.lowercased().contains(text.lowercased()) }
                self.filteredArr.sort{ $0.popularity > $1.popularity }
                print(self.filteredArr)
                
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
