//
//  ActivityWireFrame.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import Foundation
import UIKit

class ActivityWireFrame: ActivityWireFrameProtocol {
	
	// MARK:- Constants
    struct Constants {
        static let storyBoardName: String = "Main"
        static let viewIdentifier: String = "ActivityView"
    }
    
    // MARK:- Methods
    // MARK:- Public Methods
    static func createActivityView() -> ActivityView {
        // Generating module components
        let view = storyBoard.instantiateViewController(withIdentifier: Constants.viewIdentifier) as! ActivityView
        let presenter: ActivityPresenterProtocol & ActivityInteractorOutputProtocol = ActivityPresenter()
        let service = ActivityAPIDataManager()
        let interactor: ActivityInteractorInputProtocol = ActivityInteractor(service: service)
        let wireFrame: ActivityWireFrameProtocol = ActivityWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var storyBoard: UIStoryboard {
        get {
            if UIDevice.current.userInterfaceIdiom == .phone {
                return UIStoryboard(name: Constants.storyBoardName, bundle: nil)
            }else{
                return UIStoryboard(name: Constants.storyBoardName, bundle: nil)
            }
        }
    }
}
