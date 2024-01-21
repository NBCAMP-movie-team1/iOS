//
//  UserListModel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0051 on 1/19/24.
//

import Foundation

class UserListModel {
    private static var users: [UserModel] {
        get {
            guard let data = UserDefaults.standard.data(forKey: "users"),
                  let users = try? JSONDecoder().decode([UserModel].self, from: data) else {
                return []
            }
            return users
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "users")
            }
        }
    }

    static func addUser(username: String, password: String, nickname: String) {
        let newUser = UserModel(username: username, password: password, nickname: nickname)
        var existingUsers = users
        existingUsers.append(newUser)
        users = existingUsers
    }

    static func getUser(forUsername username: String) -> UserModel? {
        return users.first { $0.username == username }
    }

    static func authenticateUser(username: String, password: String) -> Bool {
        if let user = getUser(forUsername: username) {
            return user.password == password
        }
        return false
    }

}
