//
//  DetailMovieAPIModel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import Foundation

struct MovieInfo: Decodable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    let overview: String

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview
    }
}
