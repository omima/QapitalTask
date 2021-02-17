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


