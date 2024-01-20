//
//  MypageViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MypageViewController: UIViewController {
    
    let test: UILabel = {
        let label = UILabel()
        label.text = "my page"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(test)
        test.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            test.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            test.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
