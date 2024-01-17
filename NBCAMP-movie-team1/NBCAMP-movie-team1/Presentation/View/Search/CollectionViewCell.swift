//
//  CollectionViewCell.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class CollectionViewCell: UICollectionViewCell{
    var tltieLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpCell()
        setUpLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUpCell()
        setUpLabel()
    }
    
    func setUpCell() {
        tltieLabel = UILabel()
        contentView.addSubview(tltieLabel)
        tltieLabel.translatesAutoresizingMaskIntoConstraints = false
        tltieLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tltieLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
        tltieLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        tltieLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func setUpLabel() {
        tltieLabel.font = UIFont.systemFont(ofSize: 15)
        tltieLabel.textAlignment = .center
    }
}
