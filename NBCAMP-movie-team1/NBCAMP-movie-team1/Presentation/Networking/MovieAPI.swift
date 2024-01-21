//
//  MovieAPI.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/15/24.
//

import Foundation

final class MovieRequest {
    
    static func allMovieRequest(_ section: String, page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let apiKey = Bundle.main.apiKey
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(section)?language=ko-KR&page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        dataTask(request, completion)
    }
    
    
    static func searchMovieRequest(_ query: String, page: Int, completion: @escaping (Result<[Movie], Error>) -> Void) {
        let apiKey = Bundle.main.apiKey
        
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?query=\(query)&include_adult=false&language=ko-KR&page=\(page)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
        
        dataTask(request, completion)
    }
    
    private static func dataTask(_ request: URLRequest, _ completion: @escaping (Result<[Movie], Error>) -> Void) {
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
