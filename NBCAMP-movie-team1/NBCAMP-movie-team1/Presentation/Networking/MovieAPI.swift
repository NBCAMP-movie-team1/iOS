//
//  MovieAPI.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/15/24.
//

import Foundation

final class MovieRequest {
    
    static func makeMovieRequest(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": Bundle.main.infoDictionary?["API_KEY"] as! String
        ]
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        
                        if let results = json?["results"] as? [[String: Any]] {
                            let jsonData = try JSONSerialization.data(withJSONObject: results, options: [])
                            let movies = try JSONDecoder().decode([Movie].self, from: jsonData)
                            completion(.success(movies))
                        } else {
                            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "Expected 'results' key in JSON"))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
        }
        
        task.resume()
    }
}
