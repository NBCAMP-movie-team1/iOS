//
//  MovieListViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let movieListView = MovieListView()
    let detailMovieViewController: DetailMovieViewController
    
    // MARK: - Life Cycle
    
    init(detailMovieViewController: DetailMovieViewController) {
        self.detailMovieViewController = detailMovieViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension MovieListViewController {
    @objc private func goToDetailMovieButton() {
        self.navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        movieListView.button.addTarget(self, action: #selector(goToDetailMovieButton), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(movieListView)
        
        movieListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            movieListView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            movieListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            movieListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            movieListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
