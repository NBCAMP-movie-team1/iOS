//
//  DetailMovieAPI.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import Foundation

final class DetailMovieRequest {
    static func detailMovieRequest(_ movieId: Int, completion: @escaping (Result<DetailMovie, Error>) -> Void) {
        let apiKey = Bundle.main.apiKey
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)?language=en-US")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }else if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let movie = try decoder.decode(DetailMovie.self, from: data)
                        completion(.success(movie))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
