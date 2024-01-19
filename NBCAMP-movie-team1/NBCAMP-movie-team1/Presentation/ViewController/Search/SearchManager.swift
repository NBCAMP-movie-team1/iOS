//
//  SearchManager.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import Foundation
import UIKit

class SearchManager{
    var filteredArr: [MovieList] = []
    func fetchPopularMovies(completionHandler: @escaping () -> Void) {
        MovieRequest.allMovieRequest("popular", page: 1) { result in
            switch result {
            case .success(let movies):
                self.filteredArr = movies.map {
                    MovieList(title: $0.title, imagePath: $0.posterPath ?? "", popularity: $0.popularity, id: $0.id)
                }
                completionHandler()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func fetchData(text: String, completionHandler: @escaping() -> Void) {
        guard !text.isEmpty else {
            return
        }
        MovieRequest.searchMovieRequest(text, page: 1) { result in
            switch result {
            case .success(let movies):
                self.filteredArr = movies.map {
                    MovieList(title: $0.title, imagePath: $0.posterPath ?? "", popularity: $0.popularity, id: $0.id)
                }.filter { $0.title.lowercased().contains(text.lowercased()) }
                self.filteredArr.sort{ $0.popularity! > $1.popularity! }
                
                if self.filteredArr.isEmpty {
                    DispatchQueue.main.async{ self.showAlert() }
                } else {
                    completionHandler()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "알림", message: "결과 없음", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(confirm)
        
        if let topViewController = UIApplication.shared.windows.first?.rootViewController {
            topViewController.present(alert, animated: true, completion: nil)
        }
    }
}
