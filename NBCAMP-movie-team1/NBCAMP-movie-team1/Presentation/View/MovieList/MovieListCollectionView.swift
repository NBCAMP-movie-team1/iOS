//
//  MovieListCollectionView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListCollectionView: UIView {
    
    // MARK: - Properties
    
    let dumymovies = [
        MovieList(title: "영화 1", imageName: "star.fill"),
        MovieList(title: "영화 2", imageName: "star"),
        MovieList(title: "영화 3", imageName: "trash"),
        MovieList(title: "영화 4", imageName: "star"),
        MovieList(title: "영화 5", imageName: "star.fill")
    ]
    
    // MARK: - UI Properties
    
    let nowPlayingLabel: UILabel
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    init(sectionTitle: String) {
        nowPlayingLabel = MovieSectionLabel(text: sectionTitle)
        
        super.init(frame: .zero)
        
        setDelegate()
        setUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Extensions

extension MovieListCollectionView {
    private func setUI() {
        self.backgroundColor = .white
        
        [nowPlayingLabel, collectionView].forEach {
            self.addSubview($0)
        }
    }
    
    private func setLayout() {
        nowPlayingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nowPlayingLabel.topAnchor.constraint(equalTo: self.topAnchor),
            nowPlayingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nowPlayingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: nowPlayingLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    private func setDelegate() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionView

extension MovieListCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dumymovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let movie = dumymovies[indexPath.item]
        cell.configure(with: movie)
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.size.width * 0.43
        let cellHeight = cellWidth * 1.3
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
