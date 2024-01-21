//
//  UserModel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0051 on 1/18/24.
//

import Foundation

struct UserModel : Codable {
    let username: String
    let password: String
    let nickname: String

    init(username: String, password: String, nickname: String) {
        self.username = username
        self.password = password
        self.nickname = nickname
    }
}
