//
//  ActivityInteractor.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

class ActivityInteractor {
    
    // MARK:- Properties
    weak var presenter: ActivityInteractorOutputProtocol?
    private let service: ActivityAPIDataManager
    var oldestDate : String?
    var users = [User]()
    
    var activitiesLoadState: PaginatedDataLoadState<Activity> = .loading {
        didSet {
            activities = activitiesLoadState.data
            presenter?.loadStateUpdated(isLoading: activitiesLoadState.isLoading)
            presenter?.activitiesHasNextPage(nextPage: hasNextPage(with: activitiesLoadState.nextPage.from))
        }
    }
    
    var activities = [Activity]() {
        didSet {
            presenter?.activityUpdated()
        }
    }
    // MARK:- Initializers
    init(service : ActivityAPIDataManager) {
        self.service = service
    }
    
    // MARK:- Methods
    fileprivate func addUnique(newActivity: [Activity], to oldActivity: [Activity]) -> [Activity] {
        let newUniqueActivity = Set(newActivity).filter{ !Set(oldActivity.map{$0.date}).contains($0.date) }
        
        var allActivity = oldActivity
        allActivity.append(contentsOf: newUniqueActivity)
        
        return allActivity
    }
   
}

// MARK:- ActivityInteractorInputProtocol
extension ActivityInteractor: ActivityInteractorInputProtocol {
    func loadActivities() {
        activitiesLoadState = .loading
        loadNextActivities()
    }
    
    func loadNextActivities() {
        let  nextPage = activitiesLoadState.nextPage
        let startDate = DateManager.shared.convertDateToString(date: nextPage.from)
        let endDate = DateManager.shared.convertDateToString(date: nextPage.to)
        
        service.fetchActivityList(start:startDate, to: endDate) { (result) in
            switch result {
            case .success(let activityWrapper):
                self.oldestDate = activityWrapper.oldestDate
                
                let nextEndDate = DateManager.shared.getTwoWeeks(from: nextPage.from)
                
                let uniqueActivites = self.addUnique(newActivity: activityWrapper.activities, to: self.activitiesLoadState.data)
                self.activitiesLoadState = .paging(uniqueActivites, nextPage: (from: nextPage.to, to: nextEndDate))
                
            case .failure(let error):
                self.presenter?.errorOccured(error: error)
            }
        }
    }
    
    func hasNextPage(with date : Date) -> Bool {
        guard let oldest = oldestDate  else { return true}
        
        let oldDate = DateManager.shared.convertStringToDate(oldest)
        if date <= oldDate {
            return false
        }
        return true
    }
}


// MARK:- User requests
extension ActivityInteractor {
    
    func loadUserInfo(with id : Int)  {

        if getUserIfExist(with: id) != nil{
            return
        }
        service.fetchUserInfo(with: id) { (result) in
            switch result {
            case .success(let user):
                self.appendUnique(user: user)
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func appendUnique(user : User) {
        if !self.users.contains(user) {
            self.users.append(user)
            self.save(users: self.users)
        }
    }
 
    func getUserIfExist(with id: Int) -> User? {
        let user = getUsers().first{$0.id == id}
        return user
    }
    
}
// MARK:- save and retrive
extension ActivityInteractor {
    func save(users : [User]){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(users){
            UserDefaults.standard.set(encoded, forKey: "users")
        }
    }
    
    func getUsers() -> [User] {
        if let objects = UserDefaults.standard.value(forKey: "users") as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [User] {
                return objectsDecoded
            } else {
                return []
            }
        } else {
            return []
        }
    }
}
