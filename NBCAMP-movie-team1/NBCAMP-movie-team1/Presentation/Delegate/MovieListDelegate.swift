//
//  MovieListDelegate.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/20/24.
//

import Foundation

protocol MovieListCollectionViewDelegate: AnyObject {
    func didSelectMovie(withId movieId: Int)
}
