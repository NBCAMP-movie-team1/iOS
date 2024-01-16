//
//  PointButton.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

final class PointButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        
        setUI(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PointButton {
    private func setUI(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = UIColor(red: 0.00, green: 0.35, blue: 0.90, alpha: 1.00)
        layer.cornerRadius = 20
        clipsToBounds = true
        heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
    }
}
