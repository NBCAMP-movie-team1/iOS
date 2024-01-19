//
//  MovieListCollectionViewCell.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MovieListCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemGray6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI() // setUI 메서드 호출
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieList) {
        let link = "https://image.tmdb.org/t/p/w500\(movie.imagePath)"
        ImageLoader.loadImage(from: link, into: self.imageView)
        label.text = movie.title
    }
}

extension MovieListCollectionViewCell {
    private func setUI() {
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView) // contentView에 추가

        // 스택뷰 제약 조건 설정
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
