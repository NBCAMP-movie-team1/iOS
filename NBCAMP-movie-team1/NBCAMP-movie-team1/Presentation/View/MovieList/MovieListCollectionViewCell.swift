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
        imageView.contentMode = .scaleAspectFit
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
        
        [imageView, label].forEach {
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.75),
            
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            label.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
        ])
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
