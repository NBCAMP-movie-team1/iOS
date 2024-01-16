//
//  DetailViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let detailMovieView = DetailMovieView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUILayout()
    }
    
}

// MARK: - Extensions
extension DetailViewController {
    private func setUILayout() {
        view.backgroundColor = .white
        view.addSubview(detailMovieView)
        
        detailMovieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailMovieView.topAnchor.constraint(equalTo: view.topAnchor),
            detailMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
