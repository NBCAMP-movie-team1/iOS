//
//  PaymentViewConroller.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class PaymentViewController: UIViewController {
    
    // MARK: - Properties
    
    private let data: MovieInfo
    
    // MARK: - UI Properties
    
    let paymentView = PaymentView()
    
    // MARK: - Life Cycle
    
    init(data: MovieInfo) {
        self.data = data
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        paymentView.setMovieInfo(data)
        paymentView.delegate = self
    }
    
}

// MARK: - Extensions

extension PaymentViewController {
    private func setUI() {
        view.backgroundColor = .white
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

extension PaymentViewController: PaymentViewDelegate {
    func didTapOKButton() {
        navigateToNextScreen()
    }
    
    private func navigateToNextScreen() {
        if let targetViewController = self.navigationController?.viewControllers.first(where: { $0 is MovieListViewController }) {
            self.navigationController?.popToViewController(targetViewController, animated: true)
        }
    }
}
