//
//  ActivityPresenter.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

class ActivityPresenter {
    
    // MARK:- Properties
    weak var view: ActivityViewProtocol?
    var interactor: ActivityInteractorInputProtocol?
    var wireFrame: ActivityWireFrameProtocol?
    
  fileprivate  func dayDifference(from dateString : String) -> String {
        let calendar = Calendar.current
        let date = DateManager.shared.convertStringToDate(dateString)
        if calendar.isDateInYesterday(date) {
            return "Yesterday"
        }else if calendar.isDateInToday(date) {
            return "Today"
        }else {
           return DateManager.shared.convertDateString(with: dateString)
        }
    }
}

// MARK:- ActivityPresenterProtocol
extension ActivityPresenter: ActivityPresenterProtocol {
    
    func viewLoaded() {
        view?.showLoader()
        interactor?.loadActivities()
    }
    
    func numberOfItems() -> Int {
        return interactor?.activities.count ?? 0
    }
    
    func getItem(at index: Int) -> ActivityViewModel {
        let amount =  interactor!.activities[index].amount
        let date =  interactor!.activities[index].date
        let convertedDate = dayDifference(from: date)
        let message =  interactor!.activities[index].message
                
        let id = interactor!.activities[index].userId
        let image = interactor?.getUserIfExist(with: id)?.avatar
        let imageURl = URL(string: image ?? "")
        
        let activityItem =  ActivityViewModel(message: message, amount: "$\(amount)", date: convertedDate, image: imageURl)
        return activityItem
    }

    func cellWillLoad(at index: Int) {
        guard let actvities = interactor?.activities else {  return }
        let userId =  actvities[index].userId
        interactor?.loadUserInfo(with: userId)
    }
}

// MARK:- ActivityInteractorOutputProtocol
extension ActivityPresenter: ActivityInteractorOutputProtocol {
    
    func activityUpdated() {
        view?.reloadData()
    }
    
    func loadStateUpdated(isLoading: Bool) {
        if isLoading {
            view?.showLoader()
        } else {
            view?.hideLoader()
        }
    }
    
    func activitiesHasNextPage(nextPage: Bool) {
        if nextPage {
            view?.addNextPageLoader(completion: {
                self.interactor?.loadNextActivities()
            })
        } else {
            view?.removeNextPageLoader()
        }
    }
    
    func errorOccured(error: Error) {
        view?.hideLoader()
        view?.showErrorMessage(text: error.localizedDescription)
    }
}


struct ActivityViewModel {
    var message : String
    var amount : String
    var date : String
    var image : URL?
}
