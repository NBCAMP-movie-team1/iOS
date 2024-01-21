//
//  MovieSectionLabel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieSectionLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        
        setUI(text: text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieSectionLabel {
    private func setUI(text: String) {
        self.text = text
        font = UIFont.systemFont(ofSize: 25, weight: .bold)
    }
}
