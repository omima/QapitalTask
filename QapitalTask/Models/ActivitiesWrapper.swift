//
//  ActivitiesWrapper.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

struct ActivitiesWrapper : Codable {
    
    var oldestDate : String
    var activities : [Activity]
    
    enum CodingKeys: String, CodingKey {
        case oldestDate = "oldest"
        case activities = "activities"
    }
    
}

