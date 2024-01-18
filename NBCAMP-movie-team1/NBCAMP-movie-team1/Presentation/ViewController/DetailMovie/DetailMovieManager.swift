//
//  DetailMovieManager.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/18/24.
//

import UIKit

class DetailMovieManager {
    func fetchData(_ movieId: Int, completion: @escaping (MovieInfo) -> Void) {
        DetailMovieRequest.detailMovieRequest(movieId) { result in
            switch result {
            case .success(let movie):
                completion(movie)
            case .failure(let error):
                print("Error occurred while fetching the list: \(error.localizedDescription)")
            }
        }
    }
}
