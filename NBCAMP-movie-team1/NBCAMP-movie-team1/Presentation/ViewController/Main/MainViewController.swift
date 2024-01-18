//
//  ViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/15/24.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - UI Properties
    
    lazy var movieListViewController = MovieListViewController()
//    lazy var movieListViewController = MovieListViewController(detailMovieViewController: detailMovieViewController)
//    lazy var detailMovieViewController = DetailMovieViewController(paymentViewController: paymentViewController, movieId: 0)
//    let detailMovieView = DetailMovieView()
//    let paymentViewController = PaymentViewController()
//    let mypageViewController = MypageViewController()
    
    let signUserView = SignUserView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
}

// MARK: - Extensions

extension MainViewController {
    @objc private func goToMovieListButton() {
        self.navigationController?.pushViewController(movieListViewController, animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        signUserView.button.addTarget(self, action: #selector(goToMovieListButton), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(signUserView)
        
        signUserView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUserView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            signUserView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            signUserView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            signUserView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
