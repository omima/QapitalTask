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
    
}

// MARK:- ActivityPresenterProtocol
extension ActivityPresenter: ActivityPresenterProtocol {
    
    
    func viewLoaded() {
        view?.showLoader()
        interactor?.loadActivities()
        view?.addNextPageLoader(completion: {
            self.interactor?.loadNextActivities()
        })
    }
    
    func numberOfItems() -> Int {
        return interactor?.activities.count ?? 0
    }
    
    func getItem(at index: Int) -> ActivityViewModel {
        let amount =  interactor!.activities[index].amount
        let date =  interactor!.activities[index].date
        let message =  interactor!.activities[index].message
        
        let activityItem =  ActivityViewModel(message: message, amount: "$\(amount)", date: date, image: nil)
        return activityItem
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
    
    func errorOccured(error: Error) {
        view?.hideLoader()
        view?.showErrorMessage(text: error.localizedDescription)
    }
}


struct ActivityViewModel {
    var message : String
    var amount : String
    var date : String
    var image : String?
}
