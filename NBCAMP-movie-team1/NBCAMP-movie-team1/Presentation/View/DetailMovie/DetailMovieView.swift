//
//  DetailMovieView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class DetailMovieView: UIView {
    
    // MARK: - UI Properties
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30)
        label.heightAnchor.constraint(lessThanOrEqualToConstant: 40).isActive = true
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "releaseDate"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "discription discription discription discription discription discription discription discription discription discription discription discription discription discription discription discription discription disc"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let bookNowButton: UIButton = PointButton(title: "예매하기")
    
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

extension DetailMovieView {
    private func setUI() {
        self.backgroundColor = .white
    }
    
    private func setLayout() {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 15
        
        [posterImageView, titleLabel, releaseDateLabel, discriptionLabel, bookNowButton].forEach {
            stackView.addArrangedSubview($0)
        }
        
        self.addSubview(stackView)

        setAutoLayout(stackView)
    }
    
    // MARK: - Auto Layout
    
    private func setAutoLayout(_ stackView: UIStackView) {
        // stackView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
        
        // posterImageView
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5)
        ])
    }
    
}
