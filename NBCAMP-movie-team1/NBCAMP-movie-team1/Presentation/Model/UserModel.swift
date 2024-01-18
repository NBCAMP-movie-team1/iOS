//
//  UserModel.swift
//  NBCAMP-movie-team1
//
//  Created by t2023-m0051 on 1/18/24.
//

import Foundation

struct UserModel {
    static var username: String {
        get {
            UserDefaults.standard.string(forKey: "username") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "username")
        }
    }

    static var password: String {
        get {
            UserDefaults.standard.string(forKey: "password") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "password")
        }
    }
    
    static var nickname: String {
        get {
            UserDefaults.standard.string(forKey: "nickname") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "nickname")
        }
    }
}
