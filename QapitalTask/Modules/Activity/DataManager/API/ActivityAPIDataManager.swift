//
//  ActivityAPIDataManager.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

class ActivityAPIDataManager: BaseAPIService {
    
    // MARK:- Properties
    weak var interactor: ActivityInteractorInputProtocol?
    
    enum ActivityEndpoint: Endpoint {
        case activity (from : String , to : String)
        
        var path: String {
            switch self {
            case .activity:
                return "/activities"
            }
        }
        
        var parameters: [String : Any] {
            switch self {
            case .activity(let from , let to):
                return ["from": from,
                        "to": to]
            }
        }
    }

}

extension ActivityAPIDataManager {
    func fetchActivityList(start from : String , to: String ,completion: @escaping (Result<ActivitiesWrapper, Error>) -> ()) {
        let endPoint = ActivityEndpoint.activity(from: from, to: to)

        execute(endPoint:endPoint,parameters: endPoint.parameters) { (result) in
            completion(result)
        }
    }
}
