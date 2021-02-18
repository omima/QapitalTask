//
//  User.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "userId"
        case name = "displayName"
        case avatar = "avatarUrl"
    }
}


extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
}
