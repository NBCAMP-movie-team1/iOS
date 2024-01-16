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
    let paymentViewController = PaymentViewController()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
}

// MARK: - UIButton Action Methods

extension DetailViewController {
    @objc private func didTapPaymentButton() {
        self.navigationController?.pushViewController(paymentViewController, animated: true)
    }
}

// MARK: - Extensions
extension DetailViewController {
    private func setAddTarget() {
        detailMovieView.bookNowButton.addTarget(self, action: #selector(didTapPaymentButton), for: .touchUpInside)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        setAddTarget()
    }
    
    private func setLayout() {
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
