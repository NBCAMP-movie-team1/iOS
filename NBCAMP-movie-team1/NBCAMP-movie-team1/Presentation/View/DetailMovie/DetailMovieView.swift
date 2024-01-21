//
//  DetailMovieView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import UIKit

class DetailMovieView: UIView {
    
    private var data: MovieInfo?
    
    // MARK: - UI Properties
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .systemGray
        
        return label
    }()
    
    private let discriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let bookNowButton: UIButton = {
        let button = PointButton(title: "예매하기")
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)

        return button
    }()
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ data: MovieInfo) {
        DispatchQueue.main.async {
            var link: String = ""
            if data.posterPath != nil {
                link = "https://image.tmdb.org/t/p/w500\(data.posterPath!)"
            } else {
                link = "https://via.placeholder.com/100x130"
            }
            ImageLoader.loadImage(from: link, into: self.posterImageView)
            
            self.titleLabel.text = data.title
            self.releaseDateLabel.text = "개봉일 : \(String(describing: data.releaseDate))"
            self.discriptionLabel.text = data.overview
        }
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
        
        [posterImageView, titleLabel, releaseDateLabel, discriptionLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        let descriptionScrollView = UIScrollView()
        descriptionScrollView.addSubview(discriptionLabel)
        stackView.addArrangedSubview(descriptionScrollView)
        
        [stackView, bookNowButton].forEach {
            self.addSubview($0)
        }
        
        setAutoLayout(stackView, descriptionScrollView)
    }
    
    // MARK: - Auto Layout
    
    private func setAutoLayout(_ stackView: UIStackView, _ descriptionScrollView: UIScrollView) {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            posterImageView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5)
        ])
        
        descriptionScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionScrollView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
        ])
        
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discriptionLabel.topAnchor.constraint(equalTo: descriptionScrollView.topAnchor, constant: 15),
            discriptionLabel.leadingAnchor.constraint(equalTo: descriptionScrollView.leadingAnchor),
            discriptionLabel.trailingAnchor.constraint(equalTo: descriptionScrollView.trailingAnchor),
            discriptionLabel.bottomAnchor.constraint(equalTo: descriptionScrollView.bottomAnchor),
            discriptionLabel.widthAnchor.constraint(equalTo: descriptionScrollView.widthAnchor)
        ])
        
        bookNowButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookNowButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 15),
            bookNowButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bookNowButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bookNowButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
