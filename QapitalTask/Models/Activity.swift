//
//  Activity.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation


struct  Activity : Codable {
    var message : String
    var amount : Float
    var userId : Int
    var date : String
   
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case amount = "amount"
        case userId = "userId"
        case date = "timestamp"
    }
}

extension Activity: Equatable, Hashable {
    static func == (lhs: Activity, rhs: Activity) -> Bool {
        return lhs.date == rhs.date
    }
}
