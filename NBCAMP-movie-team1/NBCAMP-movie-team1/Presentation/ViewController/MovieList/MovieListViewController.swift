//
//  MovieListViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = { createStackView() }()
    
    let nowPlayingView = MovieListCollectionView(sectionTitle: "Now Playing")
    let popularView = MovieListCollectionView(sectionTitle: "Popular")
    let topRatedView = MovieListCollectionView(sectionTitle: "Top Rated")
    
    let detailMovieViewController: DetailMovieViewController
    
    // MARK: - Life Cycle
    
    init(detailMovieViewController: DetailMovieViewController) {
        self.detailMovieViewController = detailMovieViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension MovieListViewController {
    @objc private func goToDetailMovieButton() {
        self.navigationController?.pushViewController(detailMovieViewController, animated: true)
    }
    
    private func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    private func setLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        nowPlayingView.translatesAutoresizingMaskIntoConstraints = false
        popularView.translatesAutoresizingMaskIntoConstraints = false
        topRatedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nowPlayingView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3/8),
            popularView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3/8),
            topRatedView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3/8)
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 30
        
        [nowPlayingView, popularView, topRatedView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}
