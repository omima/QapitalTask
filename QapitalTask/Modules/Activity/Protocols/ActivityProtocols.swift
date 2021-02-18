//
//  ActivityProtocols.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation

// MARK:- View protocols
// MARK: Presenter -> View
protocol ActivityViewProtocol: BaseViewing {
    var presenter: ActivityPresenterProtocol? { get set }
    
    func reloadData()
    func addNextPageLoader(completion: (()->())?)
    func removeNextPageLoader()
}

// MARK:- Presenter protocols
// MARK: View -> Presenter
protocol ActivityPresenterProtocol: class {
    var view: ActivityViewProtocol? { get set }
    var interactor: ActivityInteractorInputProtocol? { get set }
    var wireFrame: ActivityWireFrameProtocol? { get set }
    
    func viewLoaded()
    func numberOfItems() -> Int
    func getItem(at index: Int) -> ActivityViewModel
    func cellWillLoad(at index: Int)
}

// MARK: Interactor -> Presenter
protocol ActivityInteractorOutputProtocol: class {
    func activityUpdated()
    func loadStateUpdated(isLoading: Bool)
    func activitiesHasNextPage(nextPage: Bool)
    func errorOccured(error: Error)
}

// MARK:- Interactor Protocols
// MARK: Presenter -> Interactor
protocol ActivityInteractorInputProtocol: class {
    var presenter: ActivityInteractorOutputProtocol? { get set }
    var activities : [Activity] { get }

    func loadActivities()
    func loadNextActivities()
    func loadUserInfo(with id : Int)
    func getUserIfExist(with id: Int) -> User?
}

// MARK:- Wireframe Protocols
protocol ActivityWireFrameProtocol: class {
    static func createActivityView() -> ActivityView
}

