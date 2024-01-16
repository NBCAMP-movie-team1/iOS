//
//  ViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/15/24.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNowPlayingList()
    }
    
}

// MARK: - API Fetch Extensions

extension MainViewController {
    func fetchNowPlayingList() {
        MovieRequest.allMovieRequest("now_playing", page: 1) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print("JSON Response: \(data)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
}
