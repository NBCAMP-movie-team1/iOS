//
//  MovieListManager.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/18/24.
//

import Foundation

class MovieListManager {
    
    var movies: [Movie] = []
    
    func fetchData(_ sectionTitle: String, completion: @escaping ([MovieList]) -> Void) {
        MovieRequest.allMovieRequest(sectionTitle, page: 1) { result in
            switch result {
            case .success(let movies):
                let first10Movies = Array(movies.prefix(10))
                self.movies = first10Movies
                
                let movieList: [MovieList] = first10Movies.map {
                    return MovieList(title: $0.title, imagePath: $0.posterPath!, popularity: $0.popularity)
                }
                
                completion(movieList)
            case .failure(let error):
                print("Error occurred while fetching the list: \(error.localizedDescription)")
                
                completion([])
            }
        }
    }
}
