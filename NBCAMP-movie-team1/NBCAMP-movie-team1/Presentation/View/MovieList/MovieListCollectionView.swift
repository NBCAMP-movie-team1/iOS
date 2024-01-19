//
//  MovieListCollectionView.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

protocol MovieListCollectionViewDelegate: AnyObject {
    func didSelectMovie(withId movieId: Int)
}

class MovieListCollectionView: UIView {
    
    // MARK: - Properties
    
    var movieList: [MovieList] = []
    weak var delegate: MovieListCollectionViewDelegate?
    
    // MARK: - UI Properties
    
    private let nowPlayingLabel: UILabel
    
    private let collectionView: UICollectionView = {
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
    
    // MARK: - Data Update Method
    
    func updateMovieList(_ movieList: [MovieList]) {
        self.movieList = movieList
        collectionView.reloadData()
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

extension MovieListCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.reuseIdentifier, for: indexPath) as! MovieListCollectionViewCell
        let movie = movieList[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.bounds.size.width * 0.43
        let cellHeight = collectionView.bounds.size.height
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movieList[indexPath.item]
        delegate?.didSelectMovie(withId: selectedMovie.id)
    }
}
