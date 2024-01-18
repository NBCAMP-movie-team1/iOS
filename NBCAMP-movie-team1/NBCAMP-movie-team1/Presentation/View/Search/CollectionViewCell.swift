//
//  CollectionViewCell.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
//    var titleLabel: UILabel!
//    var titleImage: UIImageView!
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 13)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    let titleImage: UIImageView = {
        let titleImage = UIImageView()
        titleImage.contentMode = .scaleAspectFit
        titleImage.backgroundColor = .systemMint
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        return titleImage
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        [titleLabel, titleImage].forEach {
            addSubview($0)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleImage.rightAnchor),
//            titleLabel.leftAnchor.constraint(equalTo: titleImage.leftAnchor),

            
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.topAnchor.constraint(equalTo: topAnchor),
            titleImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            titleImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.83),
        ])
    }
}
