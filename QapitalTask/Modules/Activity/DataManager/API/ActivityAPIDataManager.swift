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
        case user (id : Int)
        var path: String {
            switch self {
            case .activity:
                return "/activities"
            case.user(let id):
                return "/users/\(id)"
            }
        }
        
        var parameters: [String : Any] {
            switch self {
            case .activity(let from , let to):
                return ["from": from,
                        "to": to]
            case .user(_):
                return [:]
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
    
    func fetchUserInfo(with id : Int, completion: @escaping(Result<User,Error>) -> ()) {
        let endpoint = ActivityEndpoint.user(id: id)
        
        execute(endPoint: endpoint, parameters: [:]) { (result) in
            completion(result)
        }
    }
}
