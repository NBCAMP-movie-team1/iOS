//
//  PaymentViewConroller.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class PaymentViewController: UIViewController {
    
    // MARK: - UI Properties
    
    let paymentView = PaymentView()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
}

// MARK: - Extensions

extension PaymentViewController {
    @objc private func goToMovieListButton() {
        if let targetViewController = self.navigationController?.viewControllers.first(where: { $0 is MovieListViewController }) {
            self.navigationController?.popToViewController(targetViewController, animated: true)
        }
    }
    
    private func setUI() {
        view.backgroundColor = .white
        paymentView.button.addTarget(self, action: #selector(goToMovieListButton), for: .touchUpInside)
    }
    
    private func setLayout() {
        view.addSubview(paymentView)
        
        paymentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            paymentView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            paymentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            paymentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
