//
//  MovieListView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListView: UIView {
    
    // MARK: - UI Properties
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "This is MovieListView"
        
        return label
    }()
    
    let button: UIButton = PointButton(title: "버튼")
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension MovieListView {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        
        [testLabel, button].forEach {
            stackView.addArrangedSubview($0)
        }
        
        self.addSubview(stackView)

        setAutoLayout(stackView)
    }
    
    private func setAutoLayout(_ stackView: UIStackView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
}
