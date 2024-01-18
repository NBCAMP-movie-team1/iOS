//
//  CollectionViewCell.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{

    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    let titleImage: UIImageView = {
        let titleImage = UIImageView()
        titleImage.contentMode = .scaleAspectFit
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
        setLayout()
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleImage.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleImage.rightAnchor),
            
            titleImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleImage.topAnchor.constraint(equalTo: topAnchor),
            titleImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            titleImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.83),
        ])
    }
}
