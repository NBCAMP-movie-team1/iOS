//
//  MovieListViewController.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/17/24.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    
    private var nowPlayingList: [MovieList] = []
    private var popularList: [MovieList] = []
    private var topRatedList: [MovieList] = []
    
    // MARK: - UI Properties
    
    let searchViewController = SearchViewController()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = { createStackView() }()
    
    private let mainLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "LogoImage"))
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        return imageView
    }()
    
    private lazy var nowPlayingView: MovieListCollectionView = {
        let nowPlayingView = MovieListCollectionView(sectionTitle: "🌱 현재 상영중")
        nowPlayingView.movieList = nowPlayingList
        
        return nowPlayingView
    }()
    
    private lazy var popularView: MovieListCollectionView = {
        let nowPlayingView = MovieListCollectionView(sectionTitle: "💯 많이 본 작품")
        nowPlayingView.movieList = popularList
        
        return nowPlayingView
    }()
    
    private lazy var topRatedView: MovieListCollectionView = {
        let nowPlayingView = MovieListCollectionView(sectionTitle: "💙 관객의 선택")
        nowPlayingView.movieList = topRatedList
        
        return nowPlayingView
    }()
    
    private lazy var searchButton: UIBarButtonItem = {
        let magnifyingGlassImage = UIImage(systemName: "magnifyingglass")
        let button = UIBarButtonItem(image: magnifyingGlassImage, style: .plain, target: self, action: #selector(goToSearchViewController))
        button.tintColor = .systemGray
        
        return button
    }()
    
    private let movieListManager = MovieListManager()
    
    // MARK: - Life Cycle
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        nowPlayingView.movieList = nowPlayingList
        popularView.movieList = popularList
        topRatedView.movieList = topRatedList
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setLayout()
        setDelegate()
        setNavigationItem()
        fetchMovieListData()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Navigation

extension MovieListViewController {
    func setNavigationItem() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.rightBarButtonItem = searchButton
        self.navigationItem.titleView = mainLogo
    }
    
    @objc private func goToSearchViewController() {
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromTop
        transition.duration = 0.1

        self.navigationController?.view.layer.add(transition, forKey: kCATransition)

        self.navigationController?.pushViewController(searchViewController, animated: false)
    }
}

// MARK: - Extensions

extension MovieListViewController {
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
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nowPlayingView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3.5/10),
            popularView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3.5/10),
            topRatedView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 3.5/10)
        ])
    }
    
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40
        
        [nowPlayingView, popularView, topRatedView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }
}

extension MovieListViewController {
    func fetchMovieListData() {
        movieListManager.fetchData("now_playing") { movieList in
            DispatchQueue.main.async {
                self.nowPlayingList = movieList
                self.nowPlayingView.updateMovieList(movieList)
            }
        }
        
        movieListManager.fetchData("popular") { movieList in
            DispatchQueue.main.async {
                self.popularList = movieList
                self.popularView.updateMovieList(movieList)
            }
        }
        
        movieListManager.fetchData("top_rated") { movieList in
            DispatchQueue.main.async {
                self.topRatedList = movieList
                self.topRatedView.updateMovieList(movieList)
            }
        }
    }
}

extension MovieListViewController: MovieListCollectionViewDelegate {
    func didSelectMovie(withId movieId: Int) {
        let detailViewController = DetailMovieViewController(movieId: movieId)
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func setDelegate() {
        nowPlayingView.delegate = self
        popularView.delegate = self
        topRatedView.delegate = self
    }
}
