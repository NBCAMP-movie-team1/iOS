//
//  DetailMovieViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    private let movieId: Int
    private var data: DetailMovie?
    private let detailMovieManager = DetailMovieManager()
    
    // MARK: - UI Properties
    
    let detailMovieView = DetailMovieView()
    
    // MARK: - Life Cycle
    
    init(movieId: Int) {
        self.movieId = movieId
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        
        fetchDetailData()
    }
    
}

// MARK: - Extensions

extension DetailMovieViewController {
    @objc private func goToPaymentButton() {
        print("결제화면으로 화면 전환")
    }
    
    private func setUI() {
        view.backgroundColor = .white
        detailMovieView.bookNowButton.addTarget(self, action: #selector(goToPaymentButton), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(detailMovieView)
        
        detailMovieView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            detailMovieView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            detailMovieView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            detailMovieView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            detailMovieView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

extension DetailMovieViewController {
    private func fetchDetailData() {
        detailMovieManager.fetchData(movieId) { movie in
            self.data = movie
        }
    }
}
