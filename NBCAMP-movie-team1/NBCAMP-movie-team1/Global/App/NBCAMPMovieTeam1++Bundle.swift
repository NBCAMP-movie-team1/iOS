//
//  NBCAMPMovieTeam1++Bundle.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0035 on 1/16/24.
//

import Foundation

extension Bundle {
    var apiKey: String {
        guard let file = self.path(forResource: "MovieInfo", ofType: "plist") else { return "" }
        
        guard let resource = NSDictionary(contentsOfFile: file) else { return "" }
        guard let key = resource["API_KEY"] as? String else { fatalError("MovieInfo requires API_KEY configuration.") }
        
        return key
    }
}
