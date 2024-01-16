//
//  DetailMovieAPIModel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import Foundation

struct DetailMovie: Decodable {
    let adult: Bool
    let backdropPath: String?
    let belongsToCollection: BelongsToCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbId: String?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [SpokenLanguage]?
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int?
    
    private enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct BelongsToCollection: Decodable {
    let id: Int
    let name: String
    let posterPath: String?
    let backdropPath: String?
}

struct Genre: Decodable {
    let id: Int
    let name: String
}

struct ProductionCompany: Decodable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
}

struct ProductionCountry: Decodable {
    let iso31661: String
    let name: String
}

struct SpokenLanguage: Decodable {
    let englishName: String
    let iso6391: String
    let name: String
}
