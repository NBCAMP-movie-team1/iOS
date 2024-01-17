//
//  DetailMovieViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let detailMovieView = DetailMovieView()
    let paymentViewController: PaymentViewController
    
    // MARK: - Life Cycle
    
    init(paymentViewController: PaymentViewController) {
        self.paymentViewController = paymentViewController
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
    }
    
}

// MARK: - Extensions

extension DetailMovieViewController {
    @objc private func goToPaymentButton() {
        self.navigationController?.pushViewController(paymentViewController, animated: true)
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
